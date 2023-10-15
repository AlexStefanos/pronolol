import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:pronolol/models/country_model.dart';
import 'package:pronolol/models/team_model.dart';

var brazil = Emoji('brazi', '🇧🇷');
var vietnam = Emoji('vietnam', '🇻🇳');
var korea = Emoji('korea', '🇰🇷');
var spain = Emoji('spain', '🇪🇸');

final List<Team> teams = [
  Team('Loud', Country('Brésil', brazil.code), []),
  Team('GAM', Country('Vietnam', vietnam.code), []),
];

const Map<String, String> teamsLogo = {
  'GEN':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/e/e3/Gen.Glogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'JDG':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/0/00/JD_Gaminglogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'G2':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/7/77/G2_Esportslogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'NRG':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/e/e7/NRGlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'T1':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/a/a2/T1logo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'BLG':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/9/91/Bilibili_Gaminglogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'FNC':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/fc/Fnaticlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'C9':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/8/88/Cloud9logo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'KT':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f8/KT_Rolsterlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'LNG':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/d/d5/LNG_Esportslogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'MAD':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/3/3c/MAD_Lionslogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'TL':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f4/Team_Liquidlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'DK':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/7/73/Dplus_KIAlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'WBG':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/5/58/Weibo_Gaminglogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'GAM':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/8/8a/GAM_Esportslogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'BDS':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/9/9e/Team_BDSlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'PSG':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/4/48/PSG_Talonlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'CFO':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/b/bb/CTBC_Flying_Oysterlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'TW':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/a/a8/Team_Whaleslogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'DFM':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/a/a7/DetonatioN_FocusMelogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'R7':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/2/2a/Movistar_R7logo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244',
  'LLL':
      'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/7/76/LOUDlogo_square.png/revision/latest/scale-to-width-down/123?cb=20210604213244'
};
