from datetime import datetime
import psycopg2
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pytz

utc = pytz.utc

options = webdriver.ChromeOptions()
options.add_argument('--headless')
options.add_experimental_option('excludeSwitches', ['-enable-logging'])

conn = psycopg2.connect(user='doadmin',
                        password='AVNS_9EGTm7dmob9Nwfdwuwx',
                        host='pronolol-do-user-15603777-0.c.db.ondigitalocean.com',
                        port=25060,
                        database='main')


def to_date(value):
    data = value.replace('.', '/').split(' ')
    data[0] = data[0] + str(datetime.now().year)
    final_date = datetime.strptime(data[0] + ' ' + data[1], '%d/%m/%Y %H:%M')
    return final_date


def to_teamtag(value):
    result = value
    if value == 'SK Gaming':
        result = 'SK'
    elif value == 'Team BDS':
        result = 'BDS'
    elif value == 'G2 Esports':
        result = 'G2'
    elif value == 'Fnatic':
        result = 'FNC'
    elif value == 'Karmine Corp':
        result = 'KC'
    elif value == 'Heretics':
        result = 'TH'
    elif value == 'GIANTX':
        result = 'GX'
    elif value == 'MAD Lions KOI':
        result = 'MDK'
    elif value == 'Rogue':
        result = 'RGE'
    elif value == 'Vitality':
        result = 'VIT'

    elif value == 'T1':
        result = 'T1'
    elif value == 'Gen.G':
        result = 'GEN'
    elif value == 'Dplus Kia':
        result = 'DK'
    elif value == 'KT Rolster':
        result = 'KT'
    elif value == 'Hanwha Life':
        result = 'HLE'
    elif value == 'Brion':
        result = 'BRO'
    elif value == 'FearX':
        result = 'FOX'
    elif value == 'Nongshim RedForce':
        result = 'NS'
    elif value == 'Kwangdong Freecs':
        result = 'KDF'
    elif value == 'DRX':
        result = 'DRX'

    elif value == 'Weibo Gaming':
        result = 'WBG'
    elif value == 'LNG Esports':
        result = 'LNG'
    elif value == 'Bilibili Gaming':
        result = 'BLG'
    elif value == 'JD Gaming':
        result = 'JDG'
    elif value == 'EDward Gaming':
        result = 'EDG'
    elif value == 'Top Esports':
        result = 'TES'
    elif value == 'FunPlus Phoenix':
        result = 'FPX'
    elif value == 'Ninjas in Pyjamas':
        result = 'NIP'
    elif value == 'Oh My God':
        result = 'OMG'
    elif value == 'Team WE':
        result = 'WE'
    elif value == 'Invictus Gaming':
        result = 'IG'
    elif value == 'Anyone\'s Legend':
        result = 'AL'
    elif value == 'LGD Gaming':
        result = 'LGD'
    elif value == 'TT Gaming':
        result = 'TT'
    elif value == 'Royal Never Give Up':
        result = 'RNG'
    elif value == 'Rare Atom':
        result = 'RA'
    elif value == 'Ultra Prime':
        result = 'UP'

    elif value == 'NRG Esports':
        result = 'NRG'
    elif value == 'Cloud9':
        result = 'C9'
    elif value == 'Team Liquid':
        result = 'TL'
    elif value == 'FlyQuest eSports':
        result = 'FLY'
    elif value == '100 Thieves':
        result = '100'

    #elif value == '':
    #    result = 'R7'
    #elif value == '':
    #    result = 'EST'

    elif value == 'LOUD':
        result = 'LLL'

    elif value == 'DetonatioN FocusMe':
        result = 'DFM'

    elif value == 'PSG Talon':
        result = 'PSG'
    #elif value == '':
    #    result = 'CFO'

    elif value == 'GAM Esports':
        result = 'GAM'
    elif value == 'Vikings Esports':
        result = 'VKE'
    elif value == 'paiN Gaming':
        result = 'PNG'
    elif value == 'Fukuoka SoftBank Hawks':
        result = 'FUK'
    elif value == 'Movistar R7':
        result = 'R7'
    #elif value == '':
    #    result = 'TW'

    elif value == 'Aegis':
        result = 'AEG'
    elif value == 'BK ROG Esports':
        result = 'BKR'
    elif value == 'GameWard':
        result = 'GW'
    elif value == 'Gentle Mates':
        result = 'M8'
    elif value == 'Karmine Corp Blue':
        result = 'KCB'
    elif value == 'Solary':
        result = 'SLY'
    elif value == 'Team BDS Academy':
        result = 'BDSA'
    elif value == 'Team du Sud':
        result = 'TDS'
    elif value == 'Team GO':
        result = 'GO'
    elif value == 'Vitality.Bee':
        result = 'VITB'
    else:
        result = 'TBD'
    return result


def get_team_tricode(value):
    cursor_tricode = conn.cursor()
    cursor_tricode.execute('SELECT id FROM teams WHERE tricode = \'' + value + '\'')
    team = cursor_tricode.fetchall()
    tricode = team[0][0]
    return tricode


scrapping_result_mode = input('1 to get results from all the leagues, 0 to choose the leagues one by one : ')
if scrapping_result_mode == '0':
    choose_league = 'a'
    while (choose_league != '0') and (choose_league != 0):
        choose_league = input('Choose which League you want to get the result from : ')
        if choose_league == 'LEC':
            driver = webdriver.Chrome(options=options)
            driver.get('https://www.flashscore.fr/esports/league-of-legends/lec/calendrier/')
            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')

            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')
            bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
        elif choose_league == 'LCK':
            driver = webdriver.Chrome(options=options)
            driver.get('https://www.flashscore.fr/esports/league-of-legends/lck/calendrier/')
            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')

            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')
            bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
        elif choose_league == 'LPL':
            driver = webdriver.Chrome(options=options)
            driver.get('https://www.flashscore.fr/esports/league-of-legends/lpl/calendrier/')
            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')

            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')
            bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
        elif choose_league == 'WORLDS':
            driver = webdriver.Chrome(options=options)
            driver.get('https://www.flashscore.fr/esports/league-of-legends/world-championship/calendrier/')
            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')

            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')
            bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
        elif choose_league == 'MSI':
            driver = webdriver.Chrome(options=options)
            driver.get('https://www.flashscore.fr/esports/league-of-legends/mid-season-invitational/calendrier/')
            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')

            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')
            bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
        elif choose_league == 'LFL':
            options = webdriver.ChromeOptions()
            options.add_argument('--headless')
            options.add_experimental_option('excludeSwitches', ['-enable-logging'])
            driver = webdriver.Chrome(options=options)
            driver.get('https://www.flashscore.fr/esports/league-of-legends/lfl/calendrier/')
            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')

            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')
            bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
        elif choose_league == 'EUM':
            driver = webdriver.Chrome(options=options)
            driver.get('https://www.flashscore.fr/esports/league-of-legends/emea-masters/calendrier/')
            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')

            WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
            event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
            events = event.find_elements(By.CLASS_NAME, 'event__match')
            bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
        for event in events:
            cur = conn.cursor()
            team1 = ''
            team2 = ''
            exist = False
            if event.find_element(By.CLASS_NAME, 'event__time') is not None:
                monthday = event.find_element(By.CLASS_NAME, 'event__time').text
                date = to_date(monthday)
                date_localized = utc.localize(date)
                print(date_localized)
                try:
                    date_str = date_localized.strftime('%Y-%m-%d %H:%M:%S')
                    cursorDate = conn.cursor()
                    cursorDate.execute('SELECT DISTINCT ON (date) * FROM matches WHERE date = \'' + date_str + '\'')
                    existing_match = cursorDate.fetchall()
                    date_existing_match = existing_match[0][3]
                    team1_existing_match = existing_match[0][1]
                    team2_existing_match = existing_match[0][2]
                    exist = True
                except:
                    print('Match doesn\'t exist or has already a result')
                    date_existing_match = datetime.now()
                if date_existing_match != date_localized:
                    if event.find_element(By.CLASS_NAME, 'event__participant--home') is not None:
                        tmp_team1 = event.find_element(By.CLASS_NAME, 'event__participant--home').text
                        team1 = to_teamtag(tmp_team1)
                        if exist:
                            team1tricode = get_team_tricode(team1)
                    if event.find_element(By.CLASS_NAME, 'event__participant--away') is not None:
                        tmp_team2 = event.find_element(By.CLASS_NAME, 'event__participant--away').text
                        team2 = to_teamtag(tmp_team2)
                        if exist:
                            team2tricode = get_team_tricode(team2)
                    if exist:
                        if (team1tricode != team1_existing_match) and (team2tricode != team2_existing_match):
                            score_team1 = ''
                            score_team2 = ''
                            if event.find_element(By.CLASS_NAME, 'event__score--home') is not None:
                                score_team1 = event.find_element(By.CLASS_NAME, 'event__score--home').text
                            if event.find_element(By.CLASS_NAME, 'event__score--away') is not None:
                                score_team2 = event.find_element(By.CLASS_NAME, 'event__score--away').text
                            score = None
                            if (score_team1 != '-') and (score_team2 != '-'):
                                score = score_team1 + score_team2
                            cur.execute(
                                'INSERT INTO matches (id, date, team1, score, team2, bo, tournament) VALUES ((select max(id) from matches) + 1, %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, %s)',
                                (date_localized, team1, score, team2, bo, choose_league))
                            conn.commit()
                            print('Inserted')
                    else:
                        score_team1 = ''
                        score_team2 = ''
                        if event.find_element(By.CLASS_NAME, 'event__score--home') is not None:
                            score_team1 = event.find_element(By.CLASS_NAME, 'event__score--home').text
                        if event.find_element(By.CLASS_NAME, 'event__score--away') is not None:
                            score_team2 = event.find_element(By.CLASS_NAME, 'event__score--away').text
                        score = None
                        if (score_team1 != '-') and (score_team2 != '-'):
                            score = score_team1 + score_team2
                        cur.execute(
                            'INSERT INTO matches (id, date, team1, score, team2, bo, tournament) VALUES ((select max(id) from matches) + 1, %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, %s)',
                            (date_localized, team1, score, team2, bo, choose_league))
                        conn.commit()
                        print('Inserted')
elif scrapping_result_mode == '1':
    leagues = ['LEC', 'LCK', 'LPL', 'LFL', 'EUM'    ] #+EUM, WORLDS, MSI
    for league in leagues:
        print(league)
        events = None
        if league == 'LEC':
            try:
                driver = webdriver.Chrome(options=options)
                driver.get('https://www.flashscore.fr/esports/league-of-legends/lec/calendrier/')
                WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
                event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
                events = event.find_elements(By.CLASS_NAME, 'event__match')
                bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
            except:
                print('No matches in ' + league)
        elif league == 'LCK':
            try:
                driver = webdriver.Chrome(options=options)
                driver.get('https://www.flashscore.fr/esports/league-of-legends/lck/calendrier/')
                WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
                event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
                events = event.find_elements(By.CLASS_NAME, 'event__match')
                bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
            except:
                print('No matches in ' + league)
        elif league == 'LPL':
            try:
                driver = webdriver.Chrome(options=options)
                driver.get('https://www.flashscore.fr/esports/league-of-legends/lpl/calendrier/')
                WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
                event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
                events = event.find_elements(By.CLASS_NAME, 'event__match')
                bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
            except:
                print('No matches in ' + league)
        elif league == 'WORLDS':
            try:
                driver = webdriver.Chrome(options=options)
                driver.get('https://www.flashscore.fr/esports/league-of-legends/world-championship/calendrier/')
                WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
                event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
                events = event.find_elements(By.CLASS_NAME, 'event__match')
                bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
            except:
                print('No matches in ' + league)
        elif league == 'MSI':
            try:
                driver = webdriver.Chrome(options=options)
                driver.get('https://www.flashscore.fr/esports/league-of-legends/mid-season-invitational/calendrier/')
                WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
                event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
                events = event.find_elements(By.CLASS_NAME, 'event__match')
                bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
            except:
                print('No matches in ' + league)
        elif league == 'LFL':
            try:
                driver = webdriver.Chrome(options=options)
                driver.get('https://www.flashscore.fr/esports/league-of-legends/lfl/calendrier/')
                WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
                event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
                events = event.find_elements(By.CLASS_NAME, 'event__match')
                bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
            except:
                print('No matches in ' + league)
        elif league == 'EUM':
            try:
                driver = webdriver.Chrome(options=options)
                driver.get('https://www.flashscore.fr/esports/league-of-legends/emea-masters/calendrier/')
                WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.leagues--static')))
                event = driver.find_element(By.CSS_SELECTOR, '.leagues--static')
                events = event.find_elements(By.CLASS_NAME, 'event__match')
                bo = input('BO1? BO3? BO5? Enter 1, 3 or 5 : ')
            except:
                print('No matches in ' + league)
        if events is not None:
            for event in events:
                cur = conn.cursor()
                team1 = ''
                team2 = ''
                exist = False
                if event.find_element(By.CLASS_NAME, 'event__time') is not None:
                    monthday = event.find_element(By.CLASS_NAME, 'event__time').text
                    date = to_date(monthday)
                    date_localized = utc.localize(date)
                    print(date_localized)
                    try:
                        date_str = date_localized.strftime('%Y-%m-%d %H:%M:%S')
                        cursorDate = conn.cursor()
                        cursorDate.execute('SELECT DISTINCT ON (date) * FROM matches WHERE date = \'' + date_str + '\'')
                        existing_match = cursorDate.fetchall()
                        date_existing_match = existing_match[0][3]
                        team1_existing_match = existing_match[0][1]
                        team2_existing_match = existing_match[0][2]
                        exist = True
                    except:
                        print('Match doesn\'t exist or has already a result')
                        date_existing_match = datetime.now()
                    if date_existing_match != date_localized:
                        if event.find_element(By.CLASS_NAME, 'event__participant--home') is not None:
                            tmp_team1 = event.find_element(By.CLASS_NAME, 'event__participant--home').text
                            team1 = to_teamtag(tmp_team1)
                            if exist:
                                team1tricode = get_team_tricode(team1)
                        if event.find_element(By.CLASS_NAME, 'event__participant--away') is not None:
                            tmp_team2 = event.find_element(By.CLASS_NAME, 'event__participant--away').text
                            team2 = to_teamtag(tmp_team2)
                            if exist:
                                team2tricode = get_team_tricode(team2)
                        if exist:
                            if (team1tricode != team1_existing_match) and (team2tricode != team2_existing_match):
                                score_team1 = ''
                                score_team2 = ''
                                if event.find_element(By.CLASS_NAME, 'event__score--home') is not None:
                                    score_team1 = event.find_element(By.CLASS_NAME, 'event__score--home').text
                                if event.find_element(By.CLASS_NAME, 'event__score--away') is not None:
                                    score_team2 = event.find_element(By.CLASS_NAME, 'event__score--away').text
                                score = None
                                if (score_team1 != '-') and (score_team2 != '-'):
                                    score = score_team1 + score_team2
                                cur.execute(
                                    'INSERT INTO matches (id, date, team1, score, team2, bo, tournament) VALUES ((select max(id) from matches) + 1, %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, %s)',
                                    (date_localized, team1, score, team2, bo, league))
                                conn.commit()
                                print('Inserted')
                        else:
                            score_team1 = ''
                            score_team2 = ''
                            if event.find_element(By.CLASS_NAME, 'event__score--home') is not None:
                                score_team1 = event.find_element(By.CLASS_NAME, 'event__score--home').text
                            if event.find_element(By.CLASS_NAME, 'event__score--away') is not None:
                                score_team2 = event.find_element(By.CLASS_NAME, 'event__score--away').text
                            score = None
                            if (score_team1 != '-') and (score_team2 != '-'):
                                score = score_team1 + score_team2
                            cur.execute(
                                'INSERT INTO matches (id, date, team1, score, team2, bo, tournament) VALUES ((select max(id) from matches) + 1, %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, (SELECT id FROM teams t WHERE t.tricode = %s), %s, %s)',
                                (date_localized, team1, score, team2, bo, league))
                            conn.commit()
                            print('Inserted')
driver.quit()