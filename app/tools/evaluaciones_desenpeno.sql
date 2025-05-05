-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-05-2025 a las 04:13:49
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `evaluaciones_desenpeno`
--
CREATE DATABASE IF NOT EXISTS `evaluaciones_desenpeno` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `evaluaciones_desenpeno`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

DROP TABLE IF EXISTS `evaluaciones`;
CREATE TABLE `evaluaciones` (
  `id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `numero_pregunta` int(11) NOT NULL,
  `pregunta` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones_realizadas`
--

DROP TABLE IF EXISTS `evaluaciones_realizadas`;
CREATE TABLE `evaluaciones_realizadas` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `nombre_evaluado` varchar(100) NOT NULL,
  `cargo_evaluado` varchar(100) NOT NULL,
  `nombre_evaluador` varchar(100) NOT NULL,
  `cargo_evaluador` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos_evaluacion`
--

DROP TABLE IF EXISTS `objetivos_evaluacion`;
CREATE TABLE `objetivos_evaluacion` (
  `id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `objetivo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

DROP TABLE IF EXISTS `respuestas`;
CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `evaluacion_id` int(11) NOT NULL,
  `evaluacion_realizada_id` int(11) DEFAULT NULL,
  `valor_respuesta_id` int(11) DEFAULT NULL,
  `respuesta` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'Aux gestion humana'),
(2, 'Aux SST'),
(3, 'Aux de almacen'),
(4, 'Aux de compras'),
(5, 'Aux compras EPP'),
(6, 'Aux facturacion'),
(7, 'Aux contable'),
(8, 'Inspecto calidad'),
(9, 'Coordinador SST'),
(10, 'Coordinador logistica'),
(11, 'Coordinador compras'),
(12, 'Analista contable lider'),
(13, 'Analista de cartera'),
(14, 'Analista de costos'),
(15, 'Analista de compras'),
(16, 'Dirrecion financiera'),
(17, 'Gerente comercial'),
(18, 'Analista comercial'),
(19, 'Ejecutivo punto de venta digital'),
(20, 'Ejecutivo punto de venta'),
(21, 'Ejecutivo comercial'),
(22, 'Director gestion humanda'),
(23, 'Director produccion'),
(24, 'Coordinador de produccion'),
(25, 'Aux de procesos'),
(26, 'Supervisor montaje'),
(27, 'Supervisor inyectada'),
(28, 'Supervisor terminada'),
(29, 'Costura automatica'),
(30, 'Troquelada'),
(31, 'Vulcaizada'),
(32, 'Aux de guarnecida'),
(33, 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valores_respuesta`
--

DROP TABLE IF EXISTS `valores_respuesta`;
CREATE TABLE `valores_respuesta` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `valor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valores_respuesta`
--

INSERT INTO `valores_respuesta` (`id`, `descripcion`, `valor`) VALUES
(1, 'Siempre', 5),
(2, 'A veces', 3),
(3, 'Nunca', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `evaluaciones_realizadas`
--
ALTER TABLE `evaluaciones_realizadas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `objetivos_evaluacion`
--
ALTER TABLE `objetivos_evaluacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `evaluacion_id` (`evaluacion_id`),
  ADD KEY `evaluacion_realizada_id` (`evaluacion_realizada_id`),
  ADD KEY `valor_respuesta_id` (`valor_respuesta_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `valores_respuesta`
--
ALTER TABLE `valores_respuesta`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluaciones_realizadas`
--
ALTER TABLE `evaluaciones_realizadas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `objetivos_evaluacion`
--
ALTER TABLE `objetivos_evaluacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `valores_respuesta`
--
ALTER TABLE `valores_respuesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `objetivos_evaluacion`
--
ALTER TABLE `objetivos_evaluacion`
  ADD CONSTRAINT `objetivos_evaluacion_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_3` FOREIGN KEY (`evaluacion_realizada_id`) REFERENCES `evaluaciones_realizadas` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_4` FOREIGN KEY (`valor_respuesta_id`) REFERENCES `valores_respuesta` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
