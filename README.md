# README

List of sources:

- http://odds.cs.stonybrook.edu/
- https://sevvandi.netlify.app/post/2021-01-23-anomaly-detection-datasets/
- https://www.dbs.ifi.lmu.de/research/outlier-evaluation/
- https://compete.hexagon-ml.com/practice/competition/39/#
- https://www.cs.ucr.edu/~eamonn/time_series_data/
- https://yahooresearch.tumblr.com/post/114590420346/a-benchmark-dataset-for-time-series-anomaly
- https://resources.sei.cmu.edu/library/asset-view.cfm?assetid=508099


---

Current local database:

```
(base) ~/g/anomaly_db ❯❯❯ ./check-size.sh                                                                                                                                                                                                                                                                            master ✱
                                                     List of relations
 Schema |                          Name                           | Type  | Owner | Persistence |    Size    | Description 
--------+---------------------------------------------------------+-------+-------+-------------+------------+-------------
 public | abalone                                                 | table | rahul | permanent   | 40 MB      | 
 public | ionosphere                                              | table | rahul | permanent   | 144 kB     | 
 public | mice                                                    | table | rahul | permanent   | 170 MB     | 
 public | mtcars                                                  | table | rahul | permanent   | 8192 bytes | 
 public | nab_artificial_noanomaly                                | table | rahul | permanent   | 1360 kB    | 
 public | nab_artificial_withanomaly                              | table | rahul | permanent   | 1720 kB    | 
 public | nab_realadexchange                                      | table | rahul | permanent   | 10 MB      | 
 public | nab_realcloudwatch                                      | table | rahul | permanent   | 5008 kB    | 
 public | nab_realknowncause                                      | table | rahul | permanent   | 5424 kB    | 
 public | nab_realtraffic                                         | table | rahul | permanent   | 968 kB     | 
 public | nab_realtwitter                                         | table | rahul | permanent   | 8128 kB    | 
 public | ucr_acsf1                                               | table | rahul | permanent   | 17 MB      | 
 public | ucr_adiac                                               | table | rahul | permanent   | 8128 kB    | 
 public | ucr_all_gesture_wiimote_x                               | table | rahul | permanent   | 26 MB      | 
 public | ucr_all_gesture_wiimote_y                               | table | rahul | permanent   | 26 MB      | 
 public | ucr_all_gesture_wiimote_z                               | table | rahul | permanent   | 26 MB      | 
 public | ucr_arrow_head                                          | table | rahul | permanent   | 3160 kB    | 
 public | ucr_beef                                                | table | rahul | permanent   | 1704 kB    | 
 public | ucr_beetle_fly                                          | table | rahul | permanent   | 1248 kB    | 
 public | ucr_bird_chicken                                        | table | rahul | permanent   | 1248 kB    | 
 public | ucr_bme                                                 | table | rahul | permanent   | 1400 kB    | 
 public | ucr_car                                                 | table | rahul | permanent   | 4120 kB    | 
 public | ucr_cbf                                                 | table | rahul | permanent   | 7048 kB    | 
 public | ucr_chinatown                                           | table | rahul | permanent   | 560 kB     | 
 public | ucr_chlorine_concentration                              | table | rahul | permanent   | 41 MB      | 
 public | ucr_cin_cecg_torso                                      | table | rahul | permanent   | 134 MB     | 
 public | ucr_coffee                                              | table | rahul | permanent   | 984 kB     | 
 public | ucr_computers                                           | table | rahul | permanent   | 21 MB      | 
 public | ucr_cricket_x                                           | table | rahul | permanent   | 13 MB      | 
 public | ucr_cricket_y                                           | table | rahul | permanent   | 13 MB      | 
 public | ucr_cricket_z                                           | table | rahul | permanent   | 13 MB      | 
 public | ucr_crop                                                | table | rahul | permanent   | 63 MB      | 
 public | ucr_diatom_size_reduction                               | table | rahul | permanent   | 6576 kB    | 
 public | ucr_distal_phalanx_outline_age_group                    | table | rahul | permanent   | 2584 kB    | 
 public | ucr_distal_phalanx_outline_correct                      | table | rahul | permanent   | 4168 kB    | 
 public | ucr_distal_phalanx_tw                                   | table | rahul | permanent   | 2584 kB    | 
 public | ucr_dodger_loop_day                                     | table | rahul | permanent   | 2720 kB    | 
 public | ucr_dodger_loop_game                                    | table | rahul | permanent   | 2720 kB    | 
 public | ucr_dodger_loop_weekend                                 | table | rahul | permanent   | 2720 kB    | 
 public | ucr_earthquakes                                         | table | rahul | permanent   | 14 MB      | 
 public | ucr_ecg200                                              | table | rahul | permanent   | 1176 kB    | 
 public | ucr_ecg5000                                             | table | rahul | permanent   | 40 MB      | 
 public | ucr_ecg_five_days                                       | table | rahul | permanent   | 7112 kB    | 
 public | ucr_electric_devices                                    | table | rahul | permanent   | 92 MB      | 
 public | ucr_eog_horizontal_signal                               | table | rahul | permanent   | 52 MB      | 
 public | ucr_eog_vertical_signal                                 | table | rahul | permanent   | 52 MB      | 
 public | ucr_ethanol_level                                       | table | rahul | permanent   | 101 MB     | 
 public | ucr_face_all                                            | table | rahul | permanent   | 17 MB      | 
 public | ucr_face_four                                           | table | rahul | permanent   | 2352 kB    | 
 public | ucr_faces_ucr                                           | table | rahul | permanent   | 17 MB      | 
 public | ucr_fifty_words                                         | table | rahul | permanent   | 14 MB      | 
 public | ucr_fish                                                | table | rahul | permanent   | 9576 kB    | 
 public | ucr_ford_a                                              | table | rahul | permanent   | 141 MB     | 
 public | ucr_ford_b                                              | table | rahul | permanent   | 128 MB     | 
 public | ucr_freezer_regular_train                               | table | rahul | permanent   | 52 MB      | 
 public | ucr_freezer_small_train                                 | table | rahul | permanent   | 50 MB      | 
 public | ucr_fungi                                               | table | rahul | permanent   | 2456 kB    | 
 public | ucr_gesture_mid_air_d1                                  | table | rahul | permanent   | 6704 kB    | 
 public | ucr_gesture_mid_air_d2                                  | table | rahul | permanent   | 6704 kB    | 
 public | ucr_gesture_mid_air_d3                                  | table | rahul | permanent   | 6704 kB    | 
 public | ucr_gesture_pebble_z1                                   | table | rahul | permanent   | 7632 kB    | 
 public | ucr_gesture_pebble_z2                                   | table | rahul | permanent   | 7632 kB    | 
 public | ucr_gun_point                                           | table | rahul | permanent   | 1808 kB    | 
 public | ucr_gun_point_age_span                                  | table | rahul | permanent   | 4024 kB    | 
 public | ucr_gun_point_male_versus_female                        | table | rahul | permanent   | 4024 kB    | 
 public | ucr_gun_point_old_versus_young                          | table | rahul | permanent   | 4024 kB    | 
 public | ucr_ham                                                 | table | rahul | permanent   | 5472 kB    | 
 public | ucr_hand_outlines                                       | table | rahul | permanent   | 213 MB     | 
 public | ucr_haptics                                             | table | rahul | permanent   | 29 MB      | 
 public | ucr_herring                                             | table | rahul | permanent   | 3896 kB    | 
 public | ucr_house_twenty                                        | table | rahul | permanent   | 18 MB      | 
 public | ucr_inline_skate                                        | table | rahul | permanent   | 70 MB      | 
 public | ucr_insect_epg_regular_train                            | table | rahul | permanent   | 11 MB      | 
 public | ucr_insect_epg_small_train                              | table | rahul | permanent   | 9448 kB    | 
 public | ucr_insect_wingbeat_sound                               | table | rahul | permanent   | 32 MB      | 
 public | ucr_italy_power_demand                                  | table | rahul | permanent   | 1592 kB    | 
 public | ucr_large_kitchen_appliances                            | table | rahul | permanent   | 31 MB      | 
 public | ucr_lightning2                                          | table | rahul | permanent   | 4576 kB    | 
 public | ucr_lightning7                                          | table | rahul | permanent   | 2728 kB    | 
 public | ucr_mallat                                              | table | rahul | permanent   | 141 MB     | 
 public | ucr_meat                                                | table | rahul | permanent   | 3208 kB    | 
 public | ucr_medical_images                                      | table | rahul | permanent   | 6688 kB    | 
 public | ucr_melbourne_pedestrian                                | table | rahul | permanent   | 5176 kB    | 
 public | ucr_middle_phalanx_outline_age_group                    | table | rahul | permanent   | 2648 kB    | 
 public | ucr_middle_phalanx_outline_correct                      | table | rahul | permanent   | 4240 kB    | 
 public | ucr_middle_phalanx_tw                                   | table | rahul | permanent   | 2648 kB    | 
 public | ucr_missing_value_and_variable_length_datasets_adjusted | table | rahul | permanent   | 0 bytes    | 
 public | ucr_mixed_shapes_regular_train                          | table | rahul | permanent   | 172 MB     | 
 public | ucr_mixed_shapes_small_train                            | table | rahul | permanent   | 149 MB     | 
 public | ucr_mote_strain                                         | table | rahul | permanent   | 6328 kB    | 
 public | ucr_non_invasive_fetal_ecg_thorax1                      | table | rahul | permanent   | 162 MB     | 
 public | ucr_non_invasive_fetal_ecg_thorax2                      | table | rahul | permanent   | 162 MB     | 
 public | ucr_olive_oil                                           | table | rahul | permanent   | 2056 kB    | 
 public | ucr_osu_leaf                                            | table | rahul | permanent   | 11 MB      | 
 public | ucr_phalanges_outlines_correct                          | table | rahul | permanent   | 12 MB      | 
 public | ucr_phoneme                                             | table | rahul | permanent   | 124 MB     | 
 public | ucr_pickup_gesture_wiimote_z                            | table | rahul | permanent   | 2000 kB    | 
 public | ucr_pig_airway_pressure                                 | table | rahul | permanent   | 36 MB      | 
 public | ucr_pig_art_pressure                                    | table | rahul | permanent   | 36 MB      | 
 public | ucr_pig_cvp                                             | table | rahul | permanent   | 36 MB      | 
 public | ucr_plaid                                               | table | rahul | permanent   | 75 MB      | 
 public | ucr_plane                                               | table | rahul | permanent   | 1824 kB    | 
 public | ucr_power_cons                                          | table | rahul | permanent   | 3096 kB    | 
 public | ucr_proximal_phalanx_outline_age_group                  | table | rahul | permanent   | 2888 kB    | 
 public | ucr_proximal_phalanx_outline_correct                    | table | rahul | permanent   | 4240 kB    | 
 public | ucr_proximal_phalanx_tw                                 | table | rahul | permanent   | 2888 kB    | 
 public | ucr_refrigeration_devices                               | table | rahul | permanent   | 31 MB      | 
 public | ucr_rock                                                | table | rahul | permanent   | 11 MB      | 
 public | ucr_screen_type                                         | table | rahul | permanent   | 31 MB      | 
 public | ucr_semg_hand_gender_ch2                                | table | rahul | permanent   | 78 MB      | 
 public | ucr_semg_hand_movement_ch2                              | table | rahul | permanent   | 78 MB      | 
 public | ucr_semg_hand_subject_ch2                               | table | rahul | permanent   | 78 MB      | 
 public | ucr_shake_gesture_wiimote_z                             | table | rahul | permanent   | 2144 kB    | 
 public | ucr_shapelet_sim                                        | table | rahul | permanent   | 5928 kB    | 
 public | ucr_shapes_all                                          | table | rahul | permanent   | 35 MB      | 
 public | ucr_small_kitchen_appliances                            | table | rahul | permanent   | 31 MB      | 
 public | ucr_smooth_subspace                                     | table | rahul | permanent   | 312 kB     | 
 public | ucr_sony_aibo_robot_surface1                            | table | rahul | permanent   | 2600 kB    | 
 public | ucr_sony_aibo_robot_surface2                            | table | rahul | permanent   | 3792 kB    | 
 public | ucr_star_light_curves                                   | table | rahul | permanent   | 543 MB     | 
 public | ucr_strawberry                                          | table | rahul | permanent   | 13 MB      | 
 public | ucr_swedish_leaf                                        | table | rahul | permanent   | 8512 kB    | 
 public | ucr_symbols                                             | table | rahul | permanent   | 23 MB      | 
 public | ucr_synthetic_control                                   | table | rahul | permanent   | 2160 kB    | 
 public | ucr_toe_segmentation1                                   | table | rahul | permanent   | 4408 kB    | 
 public | ucr_toe_segmentation2                                   | table | rahul | permanent   | 3392 kB    | 
 public | ucr_trace                                               | table | rahul | permanent   | 3280 kB    | 
 public | ucr_two_lead_ecg                                        | table | rahul | permanent   | 5648 kB    | 
 public | ucr_two_patterns                                        | table | rahul | permanent   | 37 MB      | 
 public | ucr_u_wave_gesture_library_all                          | table | rahul | permanent   | 243 MB     | 
 public | ucr_u_wave_gesture_library_x                            | table | rahul | permanent   | 81 MB      | 
 public | ucr_u_wave_gesture_library_y                            | table | rahul | permanent   | 81 MB      | 
 public | ucr_u_wave_gesture_library_z                            | table | rahul | permanent   | 81 MB      | 
 public | ucr_umd                                                 | table | rahul | permanent   | 1632 kB    | 
 public | ucr_wafer                                               | table | rahul | permanent   | 63 MB      | 
 public | ucr_wine                                                | table | rahul | permanent   | 1568 kB    | 
 public | ucr_word_synonyms                                       | table | rahul | permanent   | 14 MB      | 
 public | ucr_worms                                               | table | rahul | permanent   | 13 MB      | 
 public | ucr_worms_two_class                                     | table | rahul | permanent   | 13 MB      | 
 public | ucr_yoga                                                | table | rahul | permanent   | 81 MB      | 
 public | vast2012_node_health_ts                                 | table | rahul | permanent   | 701 MB     | 
 public | vast2012_node_meta_data                                 | table | rahul | permanent   | 84 MB      | 
(142 rows)

```