# Localization

Since support for more locales is an ongoing effort, information regarding localization will be managed in this document instead of in a forever open GitHub issue.


## TLDR;

KeyboardKit should support as many locales as possible. However, since many locales require additional layout and locale capabilities, they're not always easy to implement.

This document is therefore used to remove clutter from the issue tracker. Feel free to open issues for individual locales at https://github.com/KeyboardKit/KeyboardKit/issues.


## Contribute

If you provide substantial help to implement support for a new locale, you will be given a forever free Basic subscription for your project, or a discount on the higher tiers.


## Requested (but complicated)

These locales have been requested, and should be prioritized:

* hi - Hindi
* ja - Japanese
* km-KH - Khmer
* ko_KR Korean (South Korea)
* ne_NP - Nepali (Nepal)
* pa - Punjabi
* zh - Simplified Chinese


## Other locales

These locales and locale variants from https://gist.github.com/jacobbubu/1836273 may not have native keyboards. Only implement them upon request:

* ak Akan
* ak_GH Akan (Ghana)
* am Amharic
* am_ET Amharic (Ethiopia)
* as Assamese
* as_IN Assamese (India)
* asa Asu
* asa_TZ Asu (Tanzania)
* bem Bemba
* bem_ZM Bemba (Zambia)
* bez Bena
* bez_TZ Bena (Tanzania)
* bm Bambara
* bm_ML Bambara (Mali)
* bo Tibetan (dotted lines and arrow key to add lower accent)
* bo_CN Tibetan (China)
* bo_IN Tibetan (India)
* cgg Chiga
* cgg_UG Chiga (Uganda)
* dav Taita
* dav_KE Taita (Kenya)
* ebu Embu
* ebu_KE Embu (Kenya)
* ee Ewe
* ee_GH Ewe (Ghana)
* ee_TG Ewe (Togo)
* ff Fulah
* ff_SN Fulah (Senegal)
* gu Gujarati
* gu_IN Gujarati (India)
* guz Gusii
* guz_KE Gusii (Kenya)
* gv Manx
* gv_GB Manx (United Kingdom)
* ha Hausa (no native keyboard?)
* ha_Latn Hausa (Latin)
* ha_Latn_GH Hausa (Latin, Ghana)
* ha_Latn_NE Hausa (Latin, Niger)
* ha_Latn_NG Hausa (Latin, Nigeria)
* hi_IN Hindi (India)
* ig Igbo
* ig_NG Igbo (Nigeria)
* ii Sichuan Yi
* ii_CN Sichuan Yi (China)
* ja_JP Japanese (Japan)
* jmc Machame
* jmc_TZ Machame (Tanzania)
* kab Kabyle
* kab_DZ Kabyle (Algeria)
* kam Kamba
* kam_KE Kamba (Kenya)
* kde Makonde (no native keyboard?)
* kea Kabuverdianu (no native keyboard?)
* kea_CV Kabuverdianu (Cape Verde)
* khq Koyra Chiini
* khq_ML Koyra Chiini (Mali)
* ki Kikuyu
* ki_KE Kikuyu (Kenya)
* kln Kalenjin (no native keyboard?)
* kln_KE Kalenjin (Kenya)
* km Khmer
* km_KH Khmer (Cambodia)
* kn Kannada
* kn_IN Kannada (India)
* kok Konkani
* kok_IN Konkani (India)
* kw_GB Cornish (United Kingdom)
* lag Langi
* lag_TZ Langi (Tanzania)
* lg Ganda
* lg_UG Ganda (Uganda)
* luo Luo (no native keyboard?)
* luo_KE Luo (Kenya)
* luy Luyia
* luy_KE Luyia (Kenya)
* mas Masai
* mas_KE Masai (Kenya)
* mas_TZ Masai (Tanzania)
* mer Meru (no native keyboard?)
* mer_KE Meru (Kenya)
* mfe Morisyen (no native keyboard?)
* mfe_MU Morisyen (Mauritius)
* mg Malagasy
* mg_MG Malagasy (Madagascar)
* ml Malayalam
* ml_IN Malayalam (India)
* mr Marathi (dotted lines and complicated logic)
* mr_IN Marathi (India)
* my Burmese (dotted lines and complicated logic)
* my_MM Burmese (Myanmar [Burma])
* naq Nama
* naq_NA Nama (Namibia)
* nd North Ndebele (no native keyboard?)
* nd_ZW North Ndebele (Zimbabwe)
* ne Nepali (dotted lines and complicated logic)
* ne_IN Nepali (India)
* nyn Nyankole
* nyn_UG Nyankole (Uganda)
* om Oromo
* om_ET Oromo (Ethiopia)
* om_KE Oromo (Kenya)
* or Oriya
* or_IN Oriya (India)
* pa_Arab Punjabi (Arabic)
* pa_Arab_PK Punjabi (Arabic, Pakistan)
* pa_Guru Punjabi (Gurmukhi)
* pa_Guru_IN Punjabi (Gurmukhi, India)
* ps Pashto
* ps_AF Pashto (Afghanistan)
* rof Rombo
* rof_TZ Rombo (Tanzania)
* rw Kinyarwanda
* rw_RW Kinyarwanda (Rwanda)
* rwk Rwa
* rwk_TZ Rwa (Tanzania)
* saq Samburu
* saq_KE Samburu (Kenya)
* seh Sena (no native keyboard?)
* seh_MZ Sena (Mozambique)
* ses Koyraboro Senni
* ses_ML Koyraboro Senni (Mali)
* sg Sango (no native keyboard?)
* sg_CF Sango (Central African Republic)
* shi Tachelhit
* shi_Latn Tachelhit (Latin)
* shi_Latn_MA Tachelhit (Latin, Morocco)
* shi_Tfng Tachelhit (Tifinagh)
* shi_Tfng_MA Tachelhit (Tifinagh, Morocco)
* si Sinhala (no native keyboard?)
* si_LK Sinhala (Sri Lanka)
* sn Shona (no native keyboard?)
* sn_ZW Shona (Zimbabwe)
* so Somal (no native keyboard?)
* so_DJ Somali (Djibouti)
* so_ET Somali (Ethiopia)
* so_KE Somali (Kenya)
* so_SO Somali (Somalia)
* ta Tamil (Anjal)
* ta Tamil (Tamil 99)
* ta_IN Tamil (India)
* ta_LK Tamil (Sri Lanka)
* te Telugu (dotted lines and complicated logic)
* te_IN Telugu (India)
* teo Teso (no native keyboard?)
* teo_KE Teso (Kenya)
* teo_UG Teso (Uganda)
* th Thai (characters add to previous character)
* th_TH Thai (Thailand)
* ti Tigrinya
* ti_ER Tigrinya (Eritrea)
* ti_ET Tigrinya (Ethiopia)
* to Tonga
* to_TO Tonga (Tonga)
* tzm Central Morocco Tamazight
* tzm_Latn Central Morocco Tamazight (Latin)
* tzm_Latn_MA Central Morocco Tamazight (Latin, Morocco)
* ur Urdu
* ur_IN Urdu (India)
* ur_PK Urdu (Pakistan)
* uz_Arab Uzbek (Arabic)
* uz_Arab_AF Uzbek (Arabic, Afghanistan)
* uz_Cyrl Uzbek (Cyrillic)
* uz_Cyrl_UZ Uzbek (Cyrillic, Uzbekistan)
* vun Vunjo
* vun_TZ Vunjo (Tanzania)
* xog Soga
* xog_UG Soga (Uganda)
* yo Yoruba (no native keyboard?)
* yo_NG Yoruba (Nigeria)
* zh_Hans Chinese (Simplified Han)
* zh_Hans_CN Chinese (Simplified Han, China)
* zh_Hans_HK Chinese (Simplified Han, Hong Kong SAR China)
* zh_Hans_MO Chinese (Simplified Han, Macau SAR China)
* zh_Hans_SG Chinese (Simplified Han, Singapore)
* zh_Hant Chinese (Traditional Han)
* zh_Hant_HK Chinese (Traditional Han, Hong Kong SAR China)
* zh_Hant_MO Chinese (Traditional Han, Macau SAR China)
* zh_Hant_TW Chinese (Traditional Han, Taiwan)
