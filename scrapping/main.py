from datetime import datetime
import psycopg2
import self
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pytz

# Set up Selenium webdriver
options = webdriver.ChromeOptions()
options.add_argument('--headless')
options.add_experimental_option('excludeSwitches', ['-enable-logging'])
driver = webdriver.Chrome(options=options)
driver.get('https://lolesports.com/schedule?leagues=lec')

# Wait for the page to load and get all the match information
WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CLASS_NAME, 'Event')))
event = driver.find_element(By.CLASS_NAME, 'Event')
events = event.find_elements(By.XPATH, '*')

conn = psycopg2.connect(user = 'doadmin',
    password = 'AVNS_9EGTm7dmob9Nwfdwuwx',
    host = 'pronolol-do-user-15603777-0.c.db.ondigitalocean.com',
    port = 25060,
    database = 'main')

def to_date(value):
    data = value.split(' ')
    if data[1] == 'janvier':
        data[1] = 'january'
    elif data[1] == 'février':
        data[1] = 'february'
    elif data[1] == 'mars':
        data[1] = 'march'
    elif data[1] == 'avril':
        data[1] = 'april'
    elif data[1] == 'mai':
        data[1] = 'may'
    elif data[1] == 'juin':
        data[1] = 'june'
    elif data[1] == 'juillet':
        data[1] = 'july'
    elif data[1] == 'août':
        data[1] = 'august'
    elif data[1] == 'septembre':
        data[1] = 'september'
    elif data[1] == 'octobre':
        data[1] = 'october'
    elif data[1] == 'novembre':
        data[1] = 'november'
    elif data[1] == 'décembre':
        data[1] = 'december'
    return datetime.strptime(data[0] + ' ' + data[1], '%d %B').replace(year=2024)

utc = pytz.utc
cursorDate = conn.cursor()
cursorDate.execute('SELECT DISTINCT ON (date) * FROM matches ORDER BY date DESC LIMIT 1')
date_last_match = cursorDate.fetchall()
cleaned_date = datetime.strptime(format(date_last_match[0][3], '%d/%m/%y %H:%M:%S'), '%d/%m/%y %H:%M:%S')
date_today = datetime.now()
date_localized = datetime.now()

for event in events:
    cur = conn.cursor()
    if event.get_attribute('class') == 'EventDate':
        monthday = event.find_element(By.CLASS_NAME, 'monthday').text
        if monthday != '29 février':
            date = to_date(monthday)
            date_localized = utc.localize(date)
    elif event.get_attribute('class') == 'EventMatch':
        if len(event.find_elements(By.CLASS_NAME, 'live')) > 0:
            continue
        hour = event.find_element(By.CLASS_NAME, 'hour').text
        minute = event.find_element(By.CLASS_NAME, 'minute').text
        date_replaced = date_localized.replace(hour=int(hour), minute=int(minute))
        date_final = date_replaced.strftime('%Y-%m-%d %H:%M:%S')
        team1 = event.find_element(By.CLASS_NAME, 'team1').find_element(By.CLASS_NAME, 'tricode').text
        team2 = event.find_element(By.CLASS_NAME, 'team2').find_element(By.CLASS_NAME, 'tricode').text
        league = event.find_element(By.CLASS_NAME, 'league').find_element(By.CLASS_NAME, 'name').text
        bo = int(event.find_element(By.CLASS_NAME, 'strategy').text[-1])
        score = None
        if len(event.find_elements(By.CLASS_NAME, 'score')) > 0:
            score = event.find_element(By.CLASS_NAME, 'scoreTeam1').text + event.find_element(By.CLASS_NAME, 'scoreTeam2').text
        naive_date_localized = datetime.replace(date_localized, tzinfo=None)
        if date_today > cleaned_date:
            print('Inserted')
            cur.execute('INSERT INTO matches (id, date, team1, score, team2, bo) VALUES ((select max(id) from matches) + 1, %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s)', (date_final, team1, score, team2, bo))
            conn.commit()
        else:
            cur.execute('SELECT * FROM matches WHERE (date=\'' + date_final + '\')')
            match_date = cur.fetchall()
            if match_date and match_date[0][5] is None:
                print('Updated')
                cur.execute('UPDATE matches SET score=%s WHERE (date=\'' + date_final + '\')', score)
                conn.commit()
driver.quit()