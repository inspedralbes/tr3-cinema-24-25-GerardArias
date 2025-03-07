-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Temps de generació: 07-03-2025 a les 07:11:29
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

--
-- Bolcament de dades per a la taula `film_sessions`
--

INSERT INTO `film_sessions` (`id`, `movie_id`, `date`, `time`, `vip_enabled`, `is_discount_day`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-03-06', '16:00:16', 0, 0, NULL, '2025-03-06 11:02:25');

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
(9, '0001_01_01_000000_create_users_table', 1),
(10, '0001_01_01_000001_create_cache_table', 1),
(11, '0001_01_01_000002_create_jobs_table', 1),
(12, '2025_03_04_090447_create_personal_access_tokens_table', 1),
(13, '2025_03_04_103632_create_movies_table', 1),
(14, '2025_03_04_104929_create_film_sessions_table', 1),
(15, '2025_03_04_104930_create_seats_table', 1),
(16, '2025_03_04_104941_create_tickets_table', 1);

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
(1, 'El abismo secreto', 'Dos agentes de élite son secretamente asignados a torres de vigilancia en los lados opuestos de un vasto desfiladero, para proteger al mundo de un misterioso mal que acecha en su interior. Se unen en la distancia, pero han de mantenerse alerta para defenderse del enemigo invisible. Cuando se les revela una amenaza fatal para la humanidad, deben trabajar juntos y poner a prueba su fuerza física y mental para mantener el secreto del desfiladero antes de que sea demasiado tarde.', 127, 'Romance, Ciencia ficción, Suspense', 'https://image.tmdb.org/t/p/w500/3s0jkMh0YUhIeIeioH3kt2X4st4.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(2, 'Amenaza en el aire', 'En este claustrofóbico thriller, un piloto (Mark Wahlberg) transporta en su avioneta a una teniente general (Michelle Dockery) que custodia a un testigo (Topher Grace) que va a testificar en un juicio contra la mafia. A medida que atraviesan las montañas de Alaska, las tensiones se disparan, ya que no todo el mundo a bordo es quien parece ser. Y a 3.000 metros de altura no hay escapatoria posible.', 91, 'Acción, Suspense, Crimen', 'https://image.tmdb.org/t/p/w500/8T6nkYb4W8BIeafmFffyfsRciTL.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(3, 'Mufasa: El rey león', 'Rafiki debe transmitir la leyenda de Mufasa a la joven cachorro de león Kiara, hija de Simba y Nala, y con Timón y Pumba prestando su estilo característico. Mufasa, un cachorro huérfano, perdido y solo, conoce a un simpático león llamado Taka, heredero de un linaje real. Este encuentro casual pone en marcha un viaje de un extraordinario grupo de inadaptados que buscan su destino.', 118, 'Aventura, Familia, Animación', 'https://image.tmdb.org/t/p/w500/dmw74cWIEKaEgl5Dv3kUTcCob6D.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(4, 'Anora', 'Anora, una joven prostituta de Brooklyn, tiene la oportunidad de vivir una historia de Cenicienta cuando conoce e impulsivamente se casa con el hijo de un oligarca. Cuando la noticia llega a Rusia, su cuento de hadas se ve amenazado, ya que los padres parten hacia Nueva York para intentar conseguir la anulación del matrimonio.', 138, 'Drama, Comedia, Romance', 'https://image.tmdb.org/t/p/w500/n5wEFSLkm2fCtN0FVAuphrCAjf8.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(5, 'Vaiana 2', 'Tras recibir una inesperada llamada de sus antepasados, Vaiana debe viajar a los lejanos mares de Oceanía y adentrarse en peligrosas aguas perdidas para vivir una aventura sin precedentes.', 99, 'Animación, Aventura, Familia, Comedia', 'https://image.tmdb.org/t/p/w500/1b2sEjyhc6kqZD4SazdVlVLuIyh.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(6, 'Sonic 3: La película', 'Sonic, Knuckles y Tails se reúnen para enfrentarse a un nuevo y poderoso adversario, Shadow, un misterioso villano cuyos poderes no se parecen a nada de lo que nuestros héroes han conocido hasta ahora. Con sus facultades superadas en todos los sentidos, el Equipo Sonic tendrá que establecer una insólita alianza con la esperanza de detener a Shadow y proteger el planeta.', 110, 'Acción, Ciencia ficción, Comedia, Familia', 'https://image.tmdb.org/t/p/w500/3aDWCRXLYOCuxjrjiPfLd79tcI6.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(7, 'Capitán América: Brave New World', 'Tras reunirse con el recién elegido presidente de los EE. UU., Thaddeus Ross, Sam se encuentra en medio de un incidente internacional. Debe descubrir el motivo que se esconde tras un perverso complot global, antes de que su verdadero artífice enfurezca al mundo entero.', 119, 'Acción, Suspense, Ciencia ficción', 'https://image.tmdb.org/t/p/w500/xVwP4GCbEfO66JSSyonnAhU3Fad.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(8, 'Amaran', 'La heroica historia del Major Mukund Varadarajan, un oficial del ejército indio que demostró una valentía extraordinaria durante una misión antiterrorista en el distrito de Shopian, en Cachemira.  La película captura su coraje al proteger a su nación y la devoción de su esposa Indhu Rebecaa Varghese.', 169, 'Acción, Drama, Aventura, Bélica', 'https://image.tmdb.org/t/p/w500/jVP3rAtgBMFH6RrSa6r4aP4wv1T.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(9, 'La acompañante', 'La muerte de un multimillonario desencadena una cadena de acontecimientos para Iris y sus amigos durante un viaje de fin de semana a su propiedad junto al lago.', 97, 'Terror, Ciencia ficción, Suspense', 'https://image.tmdb.org/t/p/w500/nyloao2GWttUvS7KVcEM2eSDwUn.jpg', '2025-03-06 08:10:39', '2025-03-06 08:10:39'),
(10, 'Flow, un mundo que salvar', 'En un mundo al borde del colapso, un gato solitario pierde su hogar por una inundación y encuentra refugio en un barco con otras especies. Juntos, deberán superar diferencias y desafíos mientras navegan por un misterioso paisaje sumergido.', 84, 'Animación, Fantasía, Aventura', 'https://image.tmdb.org/t/p/w500/337MqZW7xii2evUDVeaWXAtopff.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(11, 'Panda Plan', 'Poco después de que la legendaria estrella del kung fu Jackie Chan sea invitada a adoptar a un querido panda del zoo llamado Hu Hu, un famoso sindicato del crimen internacional pone sus ojos en el famoso oso y ofrece una enorme recompensa por su captura. Ante esta repentina crisis, Jackie Chan recurre a la ayuda de su agente y del feroz cuidador de Hu Hu, y el trío se embarca en una aventura en la que intentarán ser más listos que los malos en todo momento.', 99, 'Acción, Comedia', 'https://image.tmdb.org/t/p/w500/sul3eKDF9rb0wn2Q9wFfv61lOGi.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(12, 'Kraven the Hunter', 'Kraven, un hombre cuya compleja relación con su despiadado padre, Nikolai Kravinoff, le hace emprender un camino de venganza con brutales consecuencias, motivándole a convertirse no sólo en el mejor cazador del mundo, sino también en uno de los más temidos.', 126, 'Acción, Aventura, Suspense', 'https://image.tmdb.org/t/p/w500/ytmJ11n9gm34D1v56myjTxMaEDJ.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(13, 'Venom: El último baile', 'Eddie y Venom están a la fuga. Perseguidos por sus sendos mundos y cada vez más cercados, el dúo se ve abocado a tomar una decisión devastadora que hará que caiga el telón sobre el último baile de Venom y Eddie.', 109, 'Acción, Ciencia ficción, Aventura', 'https://image.tmdb.org/t/p/w500/8F74DwgFxTIBNtbqSLjR7zWmnHh.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(14, 'The Brutalist', 'Cuando el visionario arquitecto László Toth y su esposa Erzsébet huyen de la Europa de posguerra en 1947 para reconstruir su legado y ver el nacimiento de la América moderna, sus vidas cambian a causa de un misterioso y adinerado cliente.', 215, 'Drama', 'https://image.tmdb.org/t/p/w500/3BwkIAjAdQY5Nn4HqDuXue5IZx6.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(15, 'La sustancia', '\'Tú, pero mejor en todos los sentidos\'. Esa es la promesa de la sustancia, un producto revolucionario basado en la división celular, que crea un alter ego más joven, más bello, más perfecto.', 141, 'Terror, Ciencia ficción', 'https://image.tmdb.org/t/p/w500/w1PiIqM89r4AM7CiMEP4VLCEFUn.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(16, 'Mickey 17', 'Mickey Barnes se encuentra en la extraordinaria circunstancia de trabajar para un empleador que exige el máximo compromiso con el trabajo... morir, para ganarse la vida.', 137, 'Ciencia ficción, Comedia, Aventura, Acción', 'https://image.tmdb.org/t/p/w500/ou9BobDOvNbkFYBTlpa7x8pND4i.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(17, 'Gladiator II', 'Dieciséis años después de la muerte de Marco Aurelio, Roma está gobernada por los despiadados emperadores gemelos Geta y Caracalla. El nieto de Aurelio, Lucio Vero, vive bajo el seudónimo de Hanno con su esposa Arishat en el reino norteafricano de Numidia. El ejército romano dirigido por el general Acacio invade y conquista el reino, esclavizando a Lucio junto con otros supervivientes. Los esclavos son llevados a Ostia, donde Lucio es comprado por el maestro de cuadra Macrinus, que le promete la oportunidad de vengarse matando a Acacio si gana suficientes combates para llegar al Coliseo.', 148, 'Acción, Aventura, Drama', 'https://image.tmdb.org/t/p/w500/fbcs5AxrdXwyj1b8bGGMgC9kXrM.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(18, 'Cónclave', 'Tras la inesperada muerte del Sumo Pontífice, el cardenal Lawrence es designado como responsable para liderar uno de los rituales más secretos y antiguos del mundo: la elección de un nuevo Papa. Cuando los líderes más poderosos de la Iglesia Católica se reúnen en los salones del Vaticano, Lawrence se ve atrapado dentro de una compleja conspiración a la vez que descubre un secreto que podría sacudir los cimientos de la Iglesia.', 120, 'Drama, Suspense, Misterio', 'https://image.tmdb.org/t/p/w500/jkOgeASTlWwyKLBNblHVwWmAKhD.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(19, 'Memorias de un caracol', 'Sin descripción', 94, 'Animación, Drama, Comedia', 'https://image.tmdb.org/t/p/w500/sJ7bgsuC06tpC7wVl3LUW5cyKmX.jpg', '2025-03-06 08:10:40', '2025-03-06 08:10:40'),
(21, 'Henry Danger: La película', 'Henry Hart se convierte en un héroe local en Dystopia después de dejar atrás Swellview. Cuando las trampas de la fama comienzan a pasar factura, se produce un giro con la presentación de Missy, una superfan que pone su mundo patas arriba.', 86, 'Acción, Comedia, Familia, Ciencia ficción', 'https://image.tmdb.org/t/p/w500/dTHEq2PIRAIq4COayxraiGiaajX.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(22, 'Alarum', 'Sin descripción', 95, 'Acción, Crimen, Suspense', 'https://image.tmdb.org/t/p/w500/cjDs56iwx4i29VQ1RbSkqO9RUyU.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(23, 'Policán', 'Un perro y un agente de policía resultan heridos juntos en el trabajo. Una operación quirúrgica que les salva la vida cambia el curso de la historia cuando nace Policán. Mitad perro, mitad hombre, Policán ha jurado proteger y servir -siempre que no le distraigan las ardillas- mientras persigue tenazmente a su archienemigo: el supervillano felino Petey el Gato. Pero la rivalidad entre Policán y Petey se ve alterada por la llegada de un adorable gatito clon de Petey, Lil Petey, que cambia las reglas del juego para ambos.', 89, 'Familia, Animación, Comedia, Acción', 'https://image.tmdb.org/t/p/w500/cUzwACFxvpbsD8kBr1IUI4JtXz0.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(24, 'Wicked', 'Ambientada en la Tierra de Oz, mucho antes de la llegada de Dorothy Gale desde Kansas. Elphaba es una joven incomprendida por su inusual color verde que aún no ha descubierto su verdadero poder. Glinda es una popular joven marcada por sus privilegios y su ambición que aún no ha descubierto su verdadera pasión. Las dos se conocen como estudiantes de la Universidad Shiz, en la fantástica Tierra de Oz, y forjan una insólita pero profunda amistad. La trama abarca los acontecimientos del primer acto del musical de Broadway.', 162, 'Drama, Romance, Fantasía', 'https://image.tmdb.org/t/p/w500/1ZSVA2pNpc89C07RDgsR6p0GMs7.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(25, 'Mickey 17', 'Mickey Barnes se encuentra en la extraordinaria circunstancia de trabajar para un empleador que exige el máximo compromiso con el trabajo... morir, para ganarse la vida.', 137, 'Ciencia ficción, Comedia, Aventura, Acción', 'https://image.tmdb.org/t/p/w500/ou9BobDOvNbkFYBTlpa7x8pND4i.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(26, 'Dhoom Dhaam', 'Durante su noche de bodas, una pareja muy peculiar trata de esquivar a matones y policías tras verse envuelta en la frenética búsqueda del misterioso «Charlie».', 109, 'Comedia, Romance, Acción', 'https://image.tmdb.org/t/p/w500/2E7me3rPi8HqaeheuD86YlpNX6k.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(27, 'Solo Leveling: ReAwakening', 'Ha pasado más de una década desde que un camino llamado \"portal\" que conecta este mundo con una dimensión alternativa apareció de repente, y personas con poderes sobrehumanos llamados \"cazadores\" han despertado. Los cazadores usan sus poderes sobrehumanos para conquistar mazmorras dentro de los portales para ganarse la vida y Sung Jinwoo, un cazador del rango más bajo, es considerado como el Cazador Más débil de Toda la Humanidad. Un día se encuentra con una mazmorra doble, una mazmorra de alto nivel oculta dentro de una de bajo nivel. Frente a un Jinwoo gravemente herido, surge una misteriosa ventana hacia una misión. Al borde de la muerte, Jinwoo decide encargarse de la misión, que le convierte en la única persona capaz de subir de nivel. Largometraje formado por una recapitulación de la primera temporada de la serie de anime homónima junto con un avance exclusivo de los dos primeros episodios de la segunda temporada.', 116, 'Acción, Aventura, Fantasía, Animación', 'https://image.tmdb.org/t/p/w500/diPEcLFEb1uuUpApol1Bit6ck3l.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(28, 'The Island', 'Cuando mata a su hermano, el oficial de LAPD Mark deja la ciudad para regresar a la isla en la que creció. Buscando respuestas y, en última instancia, venganza, pronto se encuentra en una sangrienta batalla con el magnate corrupto que se ha apoderado del paraíso de la isla.', 93, 'Acción, Crimen, Suspense', 'https://image.tmdb.org/t/p/w500/ajb1rMiorchfRemYHZCkbV9DBg6.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(29, 'Culpa mía: Londres', 'Noah, de 18 años, se traslada de Estados Unidos a Londres con su madre, que se ha enamorado recientemente de William, un adinerado hombre de negocios británico. Noah conoce al hijo de William, el malote Nick. Pese a los esfuerzos de ambos por evitarlo, se sienten atraídos. Mientras Noah pasa el verano adaptándose a su nueva vida, su doloroso pasado la irá atrapando a la vez que se va enamorando.', 119, 'Romance, Drama', 'https://image.tmdb.org/t/p/w500/q0HxfkF9eoa6wSVnzwMhuDSK7ba.jpg', '2025-03-06 08:10:41', '2025-03-06 08:10:41'),
(30, 'Robot salvaje', 'Esta aventura épica cuenta la historia de una robot, Rozzum 7-1-3-4, \"Roz\" para abreviar, que naufraga en una isla inhabitada y debe aprender a adaptarse a los entornos rigurosos construyendo relaciones con los animales de la isla y convirtiéndose en la madre adoptiva de una cría de ganso huérfana.', 102, 'Animación, Ciencia ficción, Familia', 'https://image.tmdb.org/t/p/w500/a0a7RC01aTa7pOnskgJb3mCD2Ba.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(31, 'Susurros Mortales 2', 'Sin descripción', 112, 'Terror, Suspense, Acción', 'https://image.tmdb.org/t/p/w500/qhf5wLyWLRtDV2P9MKgzYrO6xYb.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(32, 'De vuelta a la acción', 'Emily y Matt renunciaron hace años a ser espías de la CIA para formar una familia. Pero, cuando se descubre su tapadera, se ven arrastrados de nuevo al mundo del espionaje.', 114, 'Acción, Comedia', 'https://image.tmdb.org/t/p/w500/mAvyQ2X3767LwXE2htvAd22ucd3.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(33, 'Francotirador: La batalla final', 'Con el fin de evitar que un traficante de armas libere una superarma mortal, el francotirador Brandon Beckett y el agente Zero son desplegados para liderar un grupo de soldados de élite en Costa Verde. Beckett se enfrenta a un nuevo reto: dar órdenes en lugar de recibirlas. Con el tiempo y la munición agotándose, deberán superar todas las adversidades para sobrevivir.', 99, 'Acción, Suspense', 'https://image.tmdb.org/t/p/w500/iEscED4NZCHsbA5maY4jnd3Z7xh.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(34, 'Gru 4. Mi villano favorito', 'Gru, Lucy y las niñas -Margo, Edith y Agnes- dan la bienvenida a un nuevo miembro en la familia: Gru Junior, que parece llegar con el propósito de ser un suplicio para su padre. Gru tendrá que enfrentarse en esta ocasión a su nueva némesis Maxime Le Mal y su sofisticada y malévola novia Valentina, lo que obligará a la familia a tener que darse a la fuga. Cuarta entrega de \'Gru, mi villano favorito\'.', 94, 'Animación, Familia, Comedia, Ciencia ficción', 'https://image.tmdb.org/t/p/w500/wTpzSDfbUuHPEgqgt5vwVtPHhrb.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(35, 'Elevation', 'Un padre soltero y dos mujeres se aventuran desde la seguridad de sus hogares a enfrentarse a criaturas monstruosas para salvar la vida de un niño.', 91, 'Acción, Ciencia ficción, Suspense', 'https://image.tmdb.org/t/p/w500/92cd9vR6ThBqT6Pe6m5daxX0rAk.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(36, 'Devara: Parte 1', 'Un intrépido hombre llamado Devara se aventura en el traicionero mundo del mar para proteger la vida de su pueblo. Ignorante de la conspiración de su hermano Bhaira, acaba transmitiendo su legado a su apacible hijo Varada.', 175, 'Acción, Drama', 'https://image.tmdb.org/t/p/w500/q9e5viGsiNXMpEKtr8KrL4rQmVW.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(37, 'Deadpool y Lobezno', 'Un apático Wade Wilson se afana en la vida civil tras dejar atrás sus días como Deadpool, un mercenario moralmente flexible. Pero cuando su mundo natal se enfrenta a una amenaza existencial, Wade debe volver a vestirse a regañadientes con un Lobezno aún más reacio a ayudar.', 127, 'Acción, Comedia, Ciencia ficción', 'https://image.tmdb.org/t/p/w500/347cCxyMXy8WkcHfsfaPaugCyPA.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(38, 'A Complete Unknown', 'Bob Dylan se hizo un nombre en el mundo del folk a muy temprana edad con sus versiones acústicas. Así que cuando en 1965, en el Newport Folk Festival, decidió conectar una guitarra eléctrica y usarla en su concierto, fue un duro golpe para los puristas del folk que veían el futuro del género en el joven. Desde ese momento, la vida de Dylan cambió profundamente. Siendo atacado por un gran grupo de seguidores del folk que lo tachaban de traidor, haciendo que su carrera no volviera a ser la misma. Ese concierto fue clave, se declaró como un músico independiente y fue el comienzo de la voz de una generación.', 140, 'Drama, Música', 'https://image.tmdb.org/t/p/w500/nQXkbxB2kqY5yyG3KTheE4WU0x4.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(39, 'Paddington: Aventura en la selva', 'Sigue a Paddington y la familia Brown mientras visitan a la tía Lucy en Perú, pero un misterio los envía a la selva amazónica y a las montañas peruanas. https://justwatch.pro/movie/516729/paddington-in-peru', 106, 'Familia, Aventura, Comedia', 'https://image.tmdb.org/t/p/w500/q06UBJxcmnjDLVQTZZ3I9n2CTZH.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42'),
(40, 'Nosferatu', 'Historia gótica de obsesión entre una joven hechizada y el aterrador vampiro encaprichado de ella que causa un indescriptible terror a su paso.', 133, 'Fantasía, Terror', 'https://image.tmdb.org/t/p/w500/jivUhECegXI3OYtPVflWoIDtENt.jpg', '2025-03-06 08:10:42', '2025-03-06 08:10:42');

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

--
-- Bolcament de dades per a la taula `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('EdbdYUFmzivg7Etvk7ynA1sp67YQrHORZPIqfYUQ', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/114.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoianpmOUZYNjRaQldObGV0UjNobnVPcWVyek92SzRvcGNFSW03akl6WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9zZXNzaW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1741262545);

-- --------------------------------------------------------

--
-- Estructura de la taula `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
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
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  ADD KEY `tickets_user_id_foreign` (`user_id`),
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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la taula `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `tickets_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `film_sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
