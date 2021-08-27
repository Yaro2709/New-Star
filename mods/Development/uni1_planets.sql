-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 20 2021 г., 16:45
-- Версия сервера: 8.0.19
-- Версия PHP: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `newstarnet`
--

-- --------------------------------------------------------

--
-- Структура таблицы `uni1_planets`
--

CREATE TABLE `uni1_planets` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(20) DEFAULT 'Hauptplanet',
  `id_owner` int UNSIGNED DEFAULT NULL,
  `universe` tinyint UNSIGNED NOT NULL,
  `galaxy` tinyint NOT NULL DEFAULT '0',
  `system` smallint NOT NULL DEFAULT '0',
  `planet` tinyint NOT NULL DEFAULT '0',
  `last_update` int DEFAULT NULL,
  `planet_type` enum('1','3') NOT NULL DEFAULT '1',
  `destruyed` int NOT NULL DEFAULT '0',
  `b_building` int NOT NULL DEFAULT '0',
  `b_building_id` text,
  `b_hangar` int NOT NULL DEFAULT '0',
  `b_hangar_id` text,
  `b_hangar_plus` int NOT NULL DEFAULT '0',
  `image` varchar(32) NOT NULL DEFAULT 'normaltempplanet01',
  `diameter` int UNSIGNED NOT NULL DEFAULT '12800',
  `field_current` smallint UNSIGNED NOT NULL DEFAULT '0',
  `field_max` smallint UNSIGNED NOT NULL DEFAULT '163',
  `temp_min` int NOT NULL DEFAULT '-17',
  `temp_max` int NOT NULL DEFAULT '23',
  `eco_hash` varchar(32) NOT NULL DEFAULT '',
  `metal` double(50,6) UNSIGNED NOT NULL DEFAULT '0.000000',
  `metal_perhour` double(50,6) NOT NULL DEFAULT '0.000000',
  `metal_max` double(50,0) UNSIGNED DEFAULT '100000',
  `crystal` double(50,6) UNSIGNED NOT NULL DEFAULT '0.000000',
  `crystal_perhour` double(50,6) NOT NULL DEFAULT '0.000000',
  `crystal_max` double(50,0) UNSIGNED DEFAULT '100000',
  `deuterium` double(50,6) UNSIGNED NOT NULL DEFAULT '0.000000',
  `deuterium_perhour` double(50,6) NOT NULL DEFAULT '0.000000',
  `deuterium_max` double(50,0) UNSIGNED DEFAULT '100000',
  `energy_used` double(50,0) NOT NULL DEFAULT '0',
  `energy` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `build_used` double(50,0) NOT NULL DEFAULT '0',
  `build` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `tech_used` double(50,0) NOT NULL DEFAULT '0',
  `tech` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `fleet_used` double(50,0) NOT NULL DEFAULT '0',
  `fleet` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `defense_used` double(50,0) NOT NULL DEFAULT '0',
  `defense` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `missile_used` double(50,0) NOT NULL DEFAULT '0',
  `missile` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `metal_mine` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `crystal_mine` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `deuterium_sintetizer` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `solar_plant` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `fusion_plant` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `robot_factory` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `nano_factory` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `hangar` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `metal_store` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `crystal_store` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `deuterium_store` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `laboratory` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `terraformer` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `university` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `ally_deposit` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `silo` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `mondbasis` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `phalanx` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `sprungtor` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `small_ship_cargo` bigint UNSIGNED NOT NULL DEFAULT '0',
  `big_ship_cargo` bigint UNSIGNED NOT NULL DEFAULT '0',
  `light_hunter` bigint UNSIGNED NOT NULL DEFAULT '0',
  `heavy_hunter` bigint UNSIGNED NOT NULL DEFAULT '0',
  `crusher` bigint UNSIGNED NOT NULL DEFAULT '0',
  `battle_ship` bigint UNSIGNED NOT NULL DEFAULT '0',
  `colonizer` bigint UNSIGNED NOT NULL DEFAULT '0',
  `recycler` bigint UNSIGNED NOT NULL DEFAULT '0',
  `spy_sonde` bigint UNSIGNED NOT NULL DEFAULT '0',
  `bomber_ship` bigint UNSIGNED NOT NULL DEFAULT '0',
  `solar_satelit` bigint UNSIGNED NOT NULL DEFAULT '0',
  `destructor` bigint UNSIGNED NOT NULL DEFAULT '0',
  `dearth_star` bigint UNSIGNED NOT NULL DEFAULT '0',
  `battleship` bigint UNSIGNED NOT NULL DEFAULT '0',
  `lune_noir` bigint UNSIGNED NOT NULL DEFAULT '0',
  `ev_transporter` bigint UNSIGNED NOT NULL DEFAULT '0',
  `star_crasher` bigint UNSIGNED NOT NULL DEFAULT '0',
  `giga_recykler` bigint UNSIGNED NOT NULL DEFAULT '0',
  `dm_ship` bigint NOT NULL DEFAULT '0',
  `orbital_station` bigint UNSIGNED NOT NULL DEFAULT '0',
  `misil_launcher` bigint UNSIGNED NOT NULL DEFAULT '0',
  `small_laser` bigint UNSIGNED NOT NULL DEFAULT '0',
  `big_laser` bigint UNSIGNED NOT NULL DEFAULT '0',
  `gauss_canyon` bigint UNSIGNED NOT NULL DEFAULT '0',
  `ionic_canyon` bigint UNSIGNED NOT NULL DEFAULT '0',
  `buster_canyon` bigint UNSIGNED NOT NULL DEFAULT '0',
  `small_protection_shield` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `planet_protector` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `big_protection_shield` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `graviton_canyon` bigint UNSIGNED NOT NULL DEFAULT '0',
  `interceptor_misil` bigint UNSIGNED NOT NULL DEFAULT '0',
  `interplanetary_misil` bigint UNSIGNED NOT NULL DEFAULT '0',
  `metal_mine_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `crystal_mine_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `deuterium_sintetizer_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `solar_plant_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `university_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `fusion_plant_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `robot_factory_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `nano_factory_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `hangar_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `laboratory_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `silo_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `solar_satelit_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `last_jump_time` int NOT NULL DEFAULT '0',
  `der_metal` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `der_crystal` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `id_luna` int NOT NULL DEFAULT '0',
  `last_relocate` int NOT NULL DEFAULT '0',
  `field_purchased` smallint NOT NULL DEFAULT '0',
  `diameter_purchased` smallint NOT NULL DEFAULT '0',
  `bs_class_oneil` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `flying_death` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `scrappy` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `M7` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `M19` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `M32` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `galleon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `destroyer` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `frigate` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `black_wanderer` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `lepton_gun` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `proton_gun` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `canyon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `quantum_gun` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `hydrogen_gun` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `dora_gun` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `photon_cannon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `particle_emitter` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `slim_mehador` double UNSIGNED NOT NULL DEFAULT '0',
  `iron_mehador` double UNSIGNED NOT NULL DEFAULT '0',
  `grand_mehador` double UNSIGNED NOT NULL DEFAULT '0',
  `landing` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `rocket` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `charybdis` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `uranus` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `achilles` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `phaser` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `armageddon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `sphinx` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `wyvern` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `icarus` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `griffin` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `squadron` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `neon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `torpedos` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `palatine` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `installation` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `atlantis` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `orbital_met` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `orbital_cry` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `orbital_det` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `galactic` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `orlan` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `vector` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `agat` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `lightning` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `volcano` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `typhon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `cerberus` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `grad` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `starfall` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `robot` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `droid` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `flame` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `spotlight` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `kraken` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `hydra` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `panzer` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `cthulhu` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `torpedo` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `cog` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `scout` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `fury` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `guardian` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `cutter` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `brigantine` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `raptor` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `aircraft` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `ranger` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `reaver` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `phoenix` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `hawk` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `brig` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `defender` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `dreadnought` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `galleass` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `ketch` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `titan` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `typhoon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `orion` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `mirage` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `flute` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `knarr` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `avenger` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `hammer` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `poleaxe` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `erehon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `isis` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `iron` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `corvette` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `thunder` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `hunter` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `leviathan` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `bunyip` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `dragon` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `predator` double(50,0) UNSIGNED NOT NULL DEFAULT '0', 
  `resource_module` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `defensive_module` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `military_module` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `research_module` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `resource_module_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `defensive_module_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `military_module_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  `research_module_porcent` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '10',
  
  `ghost` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `shadow` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `ripper` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `phantom` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `reaper` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `jellyfish` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `black_star` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `slayer` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `witcher` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `beagle` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `ear` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `damnation` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `thanatos` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  
  `invisible_guardian` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `darkness` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `delta_mehador` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `abyss` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `ion_complex` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `plasma_destructor` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `oblivion` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `nightmare` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `beta_mehador` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `death` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `pain` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `black_sun` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `disconnector` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  
  `alpha_mehador` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `sorrow` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `retaliation` double(50,0) UNSIGNED NOT NULL DEFAULT '0',
  `lord_darkness` double(50,0) UNSIGNED NOT NULL DEFAULT '0'
  
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `uni1_planets`
--

INSERT INTO `uni1_planets` (`id`, `name`, `id_owner`, `universe`, `galaxy`, `system`, `planet`, `last_update`, `planet_type`, `destruyed`, `b_building`, `b_building_id`, `b_hangar`, `b_hangar_id`, `b_hangar_plus`, `image`, `diameter`, `field_current`, `field_max`, `temp_min`, `temp_max`, `eco_hash`, `metal`, `metal_perhour`, `metal_max`, `crystal`, `crystal_perhour`, `crystal_max`, `deuterium`, `deuterium_perhour`, `deuterium_max`, `energy_used`, `energy`, `build_used`, `build`, `tech_used`, `tech`, `fleet_used`, `fleet`, `defense_used`, `defense`, `missile_used`, `missile`, `metal_mine`, `crystal_mine`, `deuterium_sintetizer`, `solar_plant`, `fusion_plant`, `robot_factory`, `nano_factory`, `hangar`, `metal_store`, `crystal_store`, `deuterium_store`, `laboratory`, `terraformer`, `university`, `ally_deposit`, `silo`, `mondbasis`, `phalanx`, `sprungtor`, `small_ship_cargo`, `big_ship_cargo`, `light_hunter`, `heavy_hunter`, `crusher`, `battle_ship`, `colonizer`, `recycler`, `spy_sonde`, `bomber_ship`, `solar_satelit`, `destructor`, `dearth_star`, `battleship`, `lune_noir`, `ev_transporter`, `star_crasher`, `giga_recykler`, `dm_ship`, `orbital_station`, `misil_launcher`, `small_laser`, `big_laser`, `gauss_canyon`, `ionic_canyon`, `buster_canyon`, `small_protection_shield`, `planet_protector`, `big_protection_shield`, `graviton_canyon`, `interceptor_misil`, `interplanetary_misil`, `metal_mine_porcent`, `crystal_mine_porcent`, `deuterium_sintetizer_porcent`, `solar_plant_porcent`, `university_porcent`, `fusion_plant_porcent`, `robot_factory_porcent`, `nano_factory_porcent`, `hangar_porcent`, `laboratory_porcent`, `silo_porcent`, `solar_satelit_porcent`, `last_jump_time`, `der_metal`, `der_crystal`, `id_luna`, `last_relocate`, `field_purchased`, `diameter_purchased`, `bs_class_oneil`, `flying_death`, `scrappy`, `M7`, `M19`, `M32`, `galleon`, `destroyer`, `frigate`, `black_wanderer`, `lepton_gun`, `proton_gun`, `canyon`, `quantum_gun`, `hydrogen_gun`, `dora_gun`, `photon_cannon`, `particle_emitter`, `slim_mehador`, `iron_mehador`, `grand_mehador`, `landing`, `rocket`, `charybdis`, `uranus`, `achilles`, `phaser`, `armageddon`, `sphinx`, `wyvern`, `icarus`, `griffin`, `squadron`, `neon`, `torpedos`, `palatine`, `installation`, `atlantis`, `orbital_met`, `orbital_cry`, `orbital_det`, `galactic`, `orlan`, `vector`, `agat`, `lightning`, `volcano`, `typhon`, `cerberus`, `grad`, `starfall`, `robot`, `droid`, `flame`, `spotlight`, `kraken`, `hydra`, `panzer`, `cthulhu`, `torpedo`, `cog`, `scout`, `fury`, `guardian`, `cutter`, `brigantine`, `raptor`, `aircraft`, `ranger`, `reaver`, `phoenix`, `hawk`, `brig`, `defender`, `dreadnought`, `galleass`, `ketch`, `titan`, `typhoon`, `orion`, `mirage`, `flute`, `knarr`, `avenger`, `hammer`, `poleaxe`, `erehon`, `isis`, `iron`, `corvette`, `thunder`, `hunter`, `leviathan`, `bunyip`, `dragon`, `predator`, `resource_module`, `defensive_module`, `military_module`, `research_module`, `resource_module_porcent`, `defensive_module_porcent`, `military_module_porcent`, `research_module_porcent`

, `ghost`, `shadow`, `ripper`, `phantom`, `reaper`, `jellyfish`, `black_star`, `slayer`, `witcher`, `beagle`, `ear`, `damnation`, `thanatos`
, `invisible_guardian`, `darkness`, `delta_mehador`, `abyss`, `ion_complex`, `plasma_destructor`, `oblivion`, `nightmare`, `beta_mehador`, `death`, `pain`, `black_sun`, `disconnector`
, `alpha_mehador`, `sorrow`, `retaliation`, `lord_darkness`) VALUES
(1, 'Главная планета', 1, 1, 1, 1, 2, 1629466823, '1', 0, 0, NULL, 0, '', 0, 'trockenplanet09', 12767, 0, 163, 168, 208, '40676c4658e08f6ede08bf05ee355df4', 2845.205559, 0.000000, 10000, 1672.602777, 0.000000, 10000, 0.000000, 0.000000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '10', '10', '10', '10', '10', '10', '10', '10', '10', '10', '10', '10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '10', '10', '10', '10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `uni1_planets`
--
ALTER TABLE `uni1_planets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_luna` (`id_luna`),
  ADD KEY `id_owner` (`id_owner`),
  ADD KEY `destruyed` (`destruyed`),
  ADD KEY `universe` (`universe`,`galaxy`,`system`,`planet`,`planet_type`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `uni1_planets`
--
ALTER TABLE `uni1_planets`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
