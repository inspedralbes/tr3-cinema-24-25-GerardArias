-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Temps de generació: 17-03-2025 a les 09:33:12
-- Versió del servidor: 8.0.41-0ubuntu0.22.04.1
-- Versió de PHP: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de dades: `cine`
--

-- --------------------------------------------------------

--
-- Estructura de la taula `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `film_sessions`
--

CREATE TABLE `film_sessions` (
  `id` bigint UNSIGNED NOT NULL,
  `movie_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `vip_enabled` tinyint(1) NOT NULL,
  `is_discount_day` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Bolcament de dades per a la taula `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(135, '0001_01_01_000000_create_users_table', 1),
(136, '0001_01_01_000001_create_cache_table', 1),
(137, '0001_01_01_000002_create_jobs_table', 1),
(138, '2025_03_04_090447_create_personal_access_tokens_table', 1),
(139, '2025_03_04_103632_create_movies_table', 1),
(140, '2025_03_04_104929_create_film_sessions_table', 1),
(141, '2025_03_04_104930_create_seats_table', 1),
(142, '2025_03_04_104941_create_tickets_table', 1);

-- --------------------------------------------------------

--
-- Estructura de la taula `movies`
--

CREATE TABLE `movies` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plot` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `runtime` int NOT NULL,
  `genre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `poster` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Bolcament de dades per a la taula `movies`
--

INSERT INTO `movies` (`id`, `title`, `plot`, `runtime`, `genre`, `poster`, `created_at`, `updated_at`) VALUES
(1, 'Mickey 17', 'Mickey 17, un miembro de la tripulación \'expendable\' (prescindible) enviado a un planeta helado para colonizarlo, se niega a dejar que su clon de reemplazo, Mickey 18, tome su lugar... Adaptación del libro original de Edward Ashton.', 137, 'Ciencia ficción, Comedia, Aventura', 'https://image.tmdb.org/t/p/w500/fjIHkLGIZdjKIKe252gSFt5QzVK.jpg', '2025-03-17 08:31:31', '2025-03-17 08:31:31'),
(2, 'The Metropolitan Opera: Fidelio', 'Sin descripción', 155, 'Música', 'https://image.tmdb.org/t/p/w500/zTdZGmVgjFow5MbKbq0NcIlXDtM.jpg', '2025-03-17 08:31:31', '2025-03-17 08:31:31'),
(3, 'Paradiso', 'Sin descripción', 14, 'Drama, Terror', 'https://image.tmdb.org/t/p/w500/jN5fvKt25DtWVoPTRaEQgGmmMqd.jpg', '2025-03-17 08:31:31', '2025-03-17 08:31:31'),
(4, '逃走', 'Sin descripción', 110, 'Desconocido', 'https://image.tmdb.org/t/p/w500/l8v8L2OC95tB4za2oex6wye4TwW.jpg', '2025-03-17 08:31:31', '2025-03-17 08:31:31'),
(5, 'Afterwards', 'Sin descripción', 0, 'Terror, Romance', 'https://image.tmdb.org/t/p/w500/nR5oqvfkWw94vVChRRiZRwEXhCL.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(6, 'Myself Two Seconds to Cry', 'Sin descripción', 16, 'Música', 'https://image.tmdb.org/t/p/w500/cnqztuI8rYP2XkGDvhMUmLbqnNe.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(7, 'Vodu Entre deux mondes', 'Sin descripción', 53, 'Documental', 'https://image.tmdb.org/t/p/w500/pgFFAiInWaxkK3DDceITw3wUPKM.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(8, 'Royal-ish', 'Sin descripción', 0, 'Película de TV, Comedia, Romance', 'https://image.tmdb.org/t/p/w500/eviXuwmjoxSRzAz0sdkkvOEjNgh.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(9, '我家的事', 'Sin descripción', 99, 'Drama, Familia', 'https://image.tmdb.org/t/p/w500/kLI40epleDwfcpLRC6hAAQUerA4.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(10, 'Dead-Weight', 'Sin descripción', 9, 'Suspense, Comedia', 'https://image.tmdb.org/t/p/w500/7FIlPqSh9i8uSmyrimpRj6rbWag.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(11, '真爱营业', 'Sin descripción', 0, 'Romance, Comedia', 'https://image.tmdb.org/t/p/w500/lEnfI1fM97TYUSj4NykkUwI1yYF.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(12, 'A Day', 'Sin descripción', 23, 'Drama, Suspense', 'https://image.tmdb.org/t/p/w500/cVY0jS7iRs1TQwSMQAfufKJh9sd.jpg', '2025-03-17 08:31:32', '2025-03-17 08:31:32'),
(13, 'Beneath The Tall Tree\'s Gaze', 'Sin descripción', 0, 'Drama, Terror', 'https://image.tmdb.org/t/p/w500/oVIJMEEO5elDaaFf9gyBP3HEl6M.jpg', '2025-03-17 08:31:33', '2025-03-17 08:31:33'),
(14, 'Reincarnation', 'Sin descripción', 10, 'Ciencia ficción, Misterio, Suspense', 'https://image.tmdb.org/t/p/w500/4f0yXq68ukd5VBQGustyimX9ojz.jpg', '2025-03-17 08:31:33', '2025-03-17 08:31:33'),
(15, 'Jenuh Eksistensialisme', 'Sin descripción', 5, 'Desconocido', 'https://image.tmdb.org/t/p/w500/kJGpgrsxW7ggv87vMQ1sJ6BQbAj.jpg', '2025-03-17 08:31:33', '2025-03-17 08:31:33'),
(16, 'Nanay\'s Frankenstein', 'Sin descripción', 0, 'Desconocido', 'https://image.tmdb.org/t/p/w500', '2025-03-17 08:31:33', '2025-03-17 08:31:33'),
(17, 'Sidelines', 'Sin descripción', 4, 'Drama, Familia', 'https://image.tmdb.org/t/p/w500/58pEKxrmCuetOe4Xs37k3ZZOC0O.jpg', '2025-03-17 08:31:33', '2025-03-17 08:31:33'),
(18, 'Neverwhen', 'Sin descripción', 9, 'Fantasía, Romance', 'https://image.tmdb.org/t/p/w500/aToFeUkgGl2L7xSfb8r0hBbalx5.jpg', '2025-03-17 08:31:33', '2025-03-17 08:31:33'),
(19, 'Departures', 'Sin descripción', 82, 'Desconocido', 'https://image.tmdb.org/t/p/w500/f7tWiwedxyIMg69D41deC8SxmxG.jpg', '2025-03-17 08:31:33', '2025-03-17 08:31:33'),
(20, 'Please, Don’t Cry', 'Sin descripción', 16, 'Drama', 'https://image.tmdb.org/t/p/w500/MDMGJP5Q5qdeCwcvHt4SDGfclH.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(21, 'PÉPÉ', 'Sin descripción', 0, 'Drama', 'https://image.tmdb.org/t/p/w500/wRpLZFQmd3CNcFUv8TdAIVgCalE.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(22, 'Urtajo', 'Javier, un político acomodado, se enfrenta a un dilema cuando la fuga tóxica de una empresa que financia su partido, amenaza con contaminar un pueblo colindante.  Mientras intenta encubrir el desastre y lidia con problemas personales, tiene un accidente leve con otro conductor, cuya familia resultará estar directamente afectada por el vertido.', 11, 'Suspense, Drama', 'https://image.tmdb.org/t/p/w500/mxKrVRwLBkDeIXfWUWSmvtZY0Kp.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(23, 'I\'m Not Crying, You\'re Crying', 'Sin descripción', 0, 'Desconocido', 'https://image.tmdb.org/t/p/w500/684kfaDD22ZYL7LvCcpOBS0GQfh.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(24, 'Nunami: là où le vent chante', 'Sin descripción', 0, 'Documental, Música', 'https://image.tmdb.org/t/p/w500/6UWfXSaSbXxsA9n3TTBDwW6UGxf.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(25, 'Alchemy of the Word', 'Sin descripción', 15, 'Desconocido', 'https://image.tmdb.org/t/p/w500/q4XsIeugSMtTaaXoVL73fiHu7VD.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(26, 'England’s Lions: The New Generation', 'Sin descripción', 82, 'Documental', 'https://image.tmdb.org/t/p/w500', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(27, 'Der geräderte Mensch', 'Sin descripción', 0, 'Comedia', 'https://image.tmdb.org/t/p/w500/4gQ2ZnfZ6u6WB9iWmWm9sLCLqm1.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(28, 'Залог', 'Sin descripción', 100, 'Drama, Historia', 'https://image.tmdb.org/t/p/w500/aqsDDMTnmTZwbbZmDepqLFPdoiZ.jpg', '2025-03-17 08:31:34', '2025-03-17 08:31:34'),
(29, 'Marciano García', 'Marciano García, un hombre con síndrome de Down, encuentra en su fantasía por convertirse en astronauta la excusa perfecta para no afrontar la muerte de su abuelo. Junto a su mejor amigo, Jose, hará todo lo posible para satisfacer su sueño, dejar el trabajo e huir a otro planeta.', 19, 'Drama', 'https://image.tmdb.org/t/p/w500/sdGwrjlFO9NII5mPKf57kCjX9VD.jpg', '2025-03-17 08:31:35', '2025-03-17 08:31:35'),
(30, 'Full Out', 'Sin descripción', 14, 'Desconocido', 'https://image.tmdb.org/t/p/w500/eXvVjE5RyNKbxHCmmj1DLu55GKe.jpg', '2025-03-17 08:31:35', '2025-03-17 08:31:35'),
(31, 'The Phalanx', 'Sin descripción', 13, 'Desconocido', 'https://image.tmdb.org/t/p/w500/4wgiJBrpvLh9kOe8feXd5MxLbzW.jpg', '2025-03-17 08:31:35', '2025-03-17 08:31:35'),
(32, 'Songs Overheard in the Shadows', 'Sin descripción', 22, 'Desconocido', 'https://image.tmdb.org/t/p/w500/3Cgx8CMlZ8BL4ayG9fzZYuK5fYZ.jpg', '2025-03-17 08:31:35', '2025-03-17 08:31:35'),
(33, 'גמד מחמד 4', 'Sin descripción', 22, 'Drama, Comedia, Suspense, Acción', 'https://image.tmdb.org/t/p/w500/9jw0tNgP3pRCq3WioDDbjwOI1n4.jpg', '2025-03-17 08:31:35', '2025-03-17 08:31:35'),
(34, 'Charon', 'Sin descripción', 0, 'Drama, Misterio', 'https://image.tmdb.org/t/p/w500/AaWcKpzEstnN2pexQRRFcaZC38t.jpg', '2025-03-17 08:31:35', '2025-03-17 08:31:35'),
(35, 'Y por si fuera poco, Godard', 'Sin descripción', 15, 'Desconocido', 'https://image.tmdb.org/t/p/w500/eeieVMafshP9PgwnAze9d9McoDT.jpg', '2025-03-17 08:31:35', '2025-03-17 08:31:35'),
(36, 'Final', 'Sin descripción', 10, 'Desconocido', 'https://image.tmdb.org/t/p/w500/nSNOzbstoR0dW960oT1c33qGiYz.jpg', '2025-03-17 08:31:36', '2025-03-17 08:31:36'),
(37, 'El abismo secreto', 'Dos agentes de élite son secretamente asignados a torres de vigilancia en los lados opuestos de un vasto desfiladero, para proteger al mundo de un misterioso mal que acecha en su interior. Se unen en la distancia, pero han de mantenerse alerta para defenderse del enemigo invisible. Cuando se les revela una amenaza fatal para la humanidad, deben trabajar juntos y poner a prueba su fuerza física y mental para mantener el secreto del desfiladero antes de que sea demasiado tarde.', 127, 'Romance, Ciencia ficción, Suspense', 'https://image.tmdb.org/t/p/w500/3s0jkMh0YUhIeIeioH3kt2X4st4.jpg', '2025-03-17 08:31:36', '2025-03-17 08:31:36'),
(38, 'High Rollers', 'Sin descripción', 101, 'Acción, Crimen, Suspense', 'https://image.tmdb.org/t/p/w500/hHowAaChDjwueySmwVbsjHmpWa.jpg', '2025-03-17 08:31:36', '2025-03-17 08:31:36'),
(39, 'Amenaza en el aire', 'En este claustrofóbico thriller, un piloto (Mark Wahlberg) transporta en su avioneta a una teniente general (Michelle Dockery) que custodia a un testigo (Topher Grace) que va a testificar en un juicio contra la mafia. A medida que atraviesan las montañas de Alaska, las tensiones se disparan, ya que no todo el mundo a bordo es quien parece ser. Y a 3.000 metros de altura no hay escapatoria posible.', 91, 'Acción, Suspense, Crimen', 'https://image.tmdb.org/t/p/w500/8T6nkYb4W8BIeafmFffyfsRciTL.jpg', '2025-03-17 08:31:36', '2025-03-17 08:31:36'),
(40, 'Bill Burr: Drop Dead Years', 'Sin descripción', 69, 'Comedia', 'https://image.tmdb.org/t/p/w500/6fGOGNBvI50BfzAhTyB4amn9V2C.jpg', '2025-03-17 08:31:36', '2025-03-17 08:31:36');

-- --------------------------------------------------------

--
-- Estructura de la taula `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `seats`
--

CREATE TABLE `seats` (
  `id` bigint UNSIGNED NOT NULL,
  `session_id` bigint UNSIGNED NOT NULL,
  `row` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int NOT NULL,
  `type` enum('Normal','VIP') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Disponible','Ocupada') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_id` bigint UNSIGNED NOT NULL,
  `seat_id` bigint UNSIGNED NOT NULL,
  `price` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Bolcament de dades per a la taula `users`
--

INSERT INTO `users` (`id`, `name`, `lastname`, `email`, `email_verified_at`, `password`, `phone`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', NULL, 'test@example.com', '2025-03-17 08:31:24', '$2y$12$.uHua9u5QXlAyWnmtGF2pexGGVKTQcUrb1DKmRWoWu1vMtH3.8zUS', NULL, '0BXRpo88oF', '2025-03-17 08:31:25', '2025-03-17 08:31:25');

--
-- Índexs per a les taules bolcades
--

--
-- Índexs per a la taula `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Índexs per a la taula `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Índexs per a la taula `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Índexs per a la taula `film_sessions`
--
ALTER TABLE `film_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `film_sessions_movie_id_foreign` (`movie_id`);

--
-- Índexs per a la taula `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Índexs per a la taula `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Índexs per a la taula `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índexs per a la taula `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`);

--
-- Índexs per a la taula `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Índexs per a la taula `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Índexs per a la taula `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `seats_session_id_row_number_unique` (`session_id`,`row`,`number`);

--
-- Índexs per a la taula `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Índexs per a la taula `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tickets_session_id_foreign` (`session_id`),
  ADD KEY `tickets_seat_id_foreign` (`seat_id`);

--
-- Índexs per a la taula `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT per les taules bolcades
--

--
-- AUTO_INCREMENT per la taula `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `film_sessions`
--
ALTER TABLE `film_sessions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- AUTO_INCREMENT per la taula `movies`
--
ALTER TABLE `movies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT per la taula `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `seats`
--
ALTER TABLE `seats`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restriccions per a les taules bolcades
--

--
-- Restriccions per a la taula `film_sessions`
--
ALTER TABLE `film_sessions`
  ADD CONSTRAINT `film_sessions_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE;

--
-- Restriccions per a la taula `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `film_sessions` (`id`) ON DELETE CASCADE;

--
-- Restriccions per a la taula `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_seat_id_foreign` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `film_sessions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
