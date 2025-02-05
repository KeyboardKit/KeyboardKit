# Localization

Since adding support for more locales will be an ongoing effort, the information will be managed in this document instead of in an "forever open" GitHub issue.


## TLDR;

KeyboardKit should support as many locales as possible. However, since many locales require additional layout and locale capabilities, they're not always easy to implement.

This document is therefore used to remove clutter from the issue tracker. Feel free to open issues for individual locales at https://github.com/KeyboardKit/KeyboardKit/issues.


## Contribute

If you provide substantial help to implement support for a new locale, you will be given a forever free Basic subscription for your project, or a discount on the higher tiers.


## Requested (common)

These locales have been requested, and should be prioritized:

* eu_ES - Basque
* hi - Hindi
* ja - Japanese
* ko - South Korean
* pa - Punjabi
* zh - Simplified Chinese 
* vi - Vietnamese (https://github.com/KeyboardKit/KeyboardKit/issues/744)


## May be fesible

* Bulgarian QWERTY


## Requested (unusual)

These locales have been requested, but the system locale to use is not obvious:

* ?? - Pamiri Shugni (https://github.com/KeyboardKit/KeyboardKit/issues/751)
* ?? - Qaraqalpaq (https://github.com/KeyboardKit/KeyboardKit/issues/752)


## Sámi

iOS 17.2 added supports for 8 native Sámi keyboards, of which these are not yet supported:

* Lule Sámi
* Pite Sámi
* Southern Sámi
* Ume Sámi
* Kildin Sámi
* Skolt Sámi


## Other locales

These locales from https://gist.github.com/jacobbubu/1836273 may not have native keyboards:

* ta Tamil (Anjal)
* ta Tamil (Tamil 99)
* my Burmese (dotted lines and complicated logic)
* bo Tibetan (dotted lines and arrow key to add lower accent)
* bs Bosnian (no native keyboard?)
* ha Hausa (no native keyboard?)
* kea Kabuverdianu (no native keyboard?)
* kln Kalenjin (no native keyboard?)
* luo Luo (no native keyboard?)
* kde Makonde (no native keyboard?)
* mr Marathi (dotted lines and complicated logic)
* mer Meru (no native keyboard?)
* mfe Morisyen (no native keyboard?)
* ne Nepali (dotted lines and complicated logic)
* nd North Ndebele (no native keyboard?)
* sg Sango (no native keyboard?)
* seh Sena (no native keyboard?)
* sn Shona (no native keyboard?)
* si Sinhala (no native keyboard?)
* so Somal (no native keyboard?)
* te Telugu (dotted lines and complicated logic)
* teo Teso (no native keyboard?)
* yo Yoruba (no native keyboard?)
* ig Igbo
* ii Sichuan Yi
* th Thai (characters add to previous character)
* ti Tigrinya
* to Tonga
* luy Luyia
* ses Koyraboro Senni
* asa Asu
* om Oromo
* jmc Machame
* or Oriya
* naq Nama
* zu Zulu
* nyn Nyankole
* ur Urdu
* ee Ewe
* bem Bemba
* eo Esperanto
* shi Tachelhit
* kok Konkani
* mas Masai
* rof Rombo
* ps Pashto
* eu Basque
* cgg Chiga
* lag Langi
* ki Kikuyu
* rwk Rwa
* bez Bena
* kk Kazakh
* kl Kalaallisut
* km Khmer
* kn Kannada
* kw Cornish
* kab Kabyle
* ff Fulah
* khq Koyra Chiini
* saq Samburu
* xog Soga
* tzm Central Morocco Tamazight
* kam Kamba
* af Afrikaans
* lg Ganda
* ebu Embu
* ak Akan
* dav Taita
* am Amharic
* as Assamese
* vun Vunjo
* az Azerbaijani
* gl Galician
* rm Romansh
* gu Gujarati
* gv Manx
* rw Kinyarwanda
* mg Malagasy
* guz Gusii
* ml Malayalam
* bm Bambara
* bn Bengali


## Locale Variants

Only implement locale variants upon request (most of these don't have native keyboards):

* mer_KE Meru (Kenya)
* ar_DZ Arabic (Algeria)
* ar_IQ Arabic (Iraq)
* ar_SY Arabic (Syria)
* zu_ZA Zulu (South Africa)
* khq_ML Koyra Chiini (Mali)
* ps_AF Pashto (Afghanistan)
* so_SO Somali (Somalia)
* sr_Cyrl Serbian (Cyrillic)
* om_KE Oromo (Kenya)
* az_Cyrl Azerbaijani (Cyrillic)
* so_ET Somali (Ethiopia)
* ii_CN Sichuan Yi (China)
* hi_IN Hindi (India)
* shi_Tfng Tachelhit (Tifinagh)
* ar_AE Arabic (United Arab Emirates)
* guz_KE Gusii (Kenya)
* rw_RW Kinyarwanda (Rwanda)
* mg_MG Malagasy (Madagascar)
* km_KH Khmer (Cambodia)
* naq_NA Nama (Namibia)
* af_NA Afrikaans (Namibia)
* kea_CV Kabuverdianu (Cape Verde)
* kok_IN Konkani (India)
* de_LI German (Liechtenstein)
* jmc_TZ Machame (Tanzania)
* chr_US Cherokee (United States)
* saq_KE Samburu (Kenya)
* lag_TZ Langi (Tanzania)
* so_DJ Somali (Djibouti)
* shi_Tfng_MA Tachelhit (Tifinagh, Morocco)
* sr_Latn_ME Serbian (Latin, Montenegro)
* sn_ZW Shona (Zimbabwe)
* or_IN Oriya (India)
* ur_IN Urdu (India)
* ha_Latn_NG Hausa (Latin, Nigeria)
* sg_CF Sango (Central African Republic)
* om_ET Oromo (Ethiopia)
* zh_Hant_MO Chinese (Traditional Han, Macau SAR China)
* ki_KE Kikuyu (Kenya)
* luy_KE Luyia (Kenya)
* pa_Guru_IN Punjabi (Gurmukhi, India)
* bo_CN Tibetan (China)
* kn_IN Kannada (India)
* sr_Cyrl_RS Serbian (Cyrillic, Serbia)
* lg_UG Ganda (Uganda)
* gu_IN Gujarati (India)
* ee_TG Ewe (Togo)
* fil_PH Filipino (Philippines)
* kam_KE Kamba (Kenya)
* ml_IN Malayalam (India)
* ro_MD Romanian (Moldova)
* kab_DZ Kabyle (Algeria)
* az_Latn Azerbaijani (Latin)
* xog_UG Soga (Uganda)
* sr_Cyrl_BA Serbian (Cyrillic, Bosnia and Herzegovina)
* si_LK Sinhala (Sri Lanka)
* luo_KE Luo (Kenya)
* it_CH Italian (Switzerland)
* uz_Cyrl_UZ Uzbek (Cyrillic, Uzbekistan)
* rm_CH Romansh (Switzerland)
* az_Cyrl_AZ Azerbaijani (Cyrillic, Azerbaijan)
* cgg_UG Chiga (Uganda)i
* mas_TZ Masai (Tanzania)
* mk_MK Macedonian (Macedonia)
* kln_KE Kalenjin (Kenya)
* sr_Latn Serbian (Latin) - Check the hyphen
* el_CY Greek (Cyprus)
* pa_Arab_PK Punjabi (Arabic, Pakistan)
* ar_YE Arabic (Yemen)
* ja_JP Japanese (Japan)
* ur_PK Urdu (Pakistan)
* pa_Guru Punjabi (Gurmukhi)
* gl_ES Galician (Spain)
* zh_Hant_HK Chinese (Traditional Han, Hong Kong SAR China)
* ar_EG Arabic (Egypt)
* th_TH Thai (Thailand)
* kk_Cyrl_KZ Kazakh (Cyrillic, Kazakhstan)
* tzm_Latn Central Morocco Tamazight (Latin)
* gsw_CH Swiss German (Switzerland)
* ha_Latn_GH Hausa (Latin, Ghana)
* zh_Hans_SG Chinese (Simplified Han, Singapore)
* mr_IN Marathi (India)
* ar_SA Arabic (Saudi Arabia)
* mfe_MU Morisyen (Mauritius)
* fr_LU French (Luxembourg)
* de_LU German (Luxembourg)
* ru_MD Russian (Moldova)
* zh_Hans_HK Chinese (Simplified Han, Hong Kong SAR China)
* shi_Latn Tachelhit (Latin)
* ko_KR Korean (South Korea)
* shi_Latn_MA Tachelhit (Latin, Morocco)
* pt_MZ Portuguese (Mozambique)
* ff_SN Fulah (Senegal)
* zh_Hans Chinese (Simplified Han)
* so_KE Somali (Kenya)
* bn_IN Bengali (India)
* id_ID Indonesian (Indonesia)
* uz_Cyrl Uzbek (Cyrillic)
* sr_Latn_BA Serbian (Latin, Bosnia and Herzegovina)
* bo_IN Tibetan (India)
* vun_TZ Vunjo (Tanzania)
* ar_SD Arabic (Sudan)
* uz_Latn_UZ Uzbek (Latin, Uzbekistan)
* az_Latn_AZ Azerbaijani (Latin, Azerbaijan)
* ta_IN Tamil (India)
* rof_TZ Rombo (Tanzania)
* ar_LY Arabic (Libya)
* ha_Latn Hausa (Latin)
* bem_ZM Bemba (Zambia)
* zh_Hans_CN Chinese (Simplified Han, China)
* bn_BD Bengali (Bangladesh)
* pt_GW Portuguese (Guinea-Bissau)
* de_AT German (Austria)
* kk_Cyrl Kazakh (Cyrillic)
* sw_TZ Swahili (Tanzania)
* ar_OM Arabic (Oman)
* zh_Hant Chinese (Traditional Han)
* bm_ML Bambara (Mali)
* ar_MA Arabic (Morocco)
* uz_Arab_AF Uzbek (Arabic, Afghanistan)
* bs_BA Bosnian (Bosnia and Herzegovina)
* am_ET Amharic (Ethiopia)
* ar_TN Arabic (Tunisia)
* haw_US Hawaiian (United States)
* ar_JO Arabic (Jordan)
* fa_AF Persian (Afghanistan)
* uz_Latn Uzbek (Latin)
* nyn_UG Nyankole (Uganda)
* ebu_KE Embu (Kenya)
* te_IN Telugu (India)
* ar_KW Arabic (Kuwait)
* af_ZA Afrikaans (South Africa)
* ti_ER Tigrinya (Eritrea)
* ig_NG Igbo (Nigeria)
* pt_PT Portuguese (Portugal)
* nd_ZW North Ndebele (Zimbabwe)
* sw_KE Swahili (Kenya)
* mas_KE Masai (Kenya)
* ti_ET Tigrinya (Ethiopia)
* ru_UA Russian (Ukraine)
* yo_NG Yoruba (Nigeria)
* dav_KE Taita (Kenya)
* gv_GB Manx (United Kingdom)
* pa_Arab Punjabi (Arabic)
* teo_UG Teso (Uganda)
* rwk_TZ Rwa (Tanzania)
* zh_Hant_TW Chinese (Traditional Han, Taiwan)
* sr_Cyrl_ME Serbian (Cyrillic, Montenegro)
* ses_ML Koyraboro Senni (Mali)
* ak_GH Akan (Ghana)
* vi_VN Vietnamese (Vietnam)
* to_TO Tonga (Tonga)
* my_MM Burmese (Myanmar [Burma])
* ar_QA Arabic (Qatar)
* ee_GH Ewe (Ghana)
* as_IN Assamese (India)
* ca_ES Catalan (Spain)
* ne_IN Nepali (India)
* ms_BN Malay (Brunei)
* ar_LB Arabic (Lebanon)
* ta_LK Tamil (Sri Lanka)
* bez_TZ Bena (Tanzania)
* uz_Arab Uzbek (Arabic)
* ne_NP Nepali (Nepal)
* zh_Hans_MO Chinese (Simplified Han, Macau SAR China)
* de_BE German (Belgium)
* sr_Latn_RS Serbian (Latin, Serbia)
* ha_Latn_NE Hausa (Latin, Niger)
* teo_KE Teso (Kenya)
* seh_MZ Sena (Mozambique)
* kl_GL Kalaallisut (Greenland)
* asa_TZ Asu (Tanzania)
* tzm_Latn_MA Central Morocco Tamazight (Latin, Morocco)
* ar_BH Arabic (Bahrain)
* kw_GB Cornish (United Kingdom)
