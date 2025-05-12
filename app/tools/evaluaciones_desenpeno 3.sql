-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-05-2025 a las 04:34:43
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

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `SP_INSERTAR_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_USUARIO` (IN `_rol_id` INT(11), IN `_nombre` VARCHAR(100), IN `_correo` VARCHAR(100), IN `_contrasena` VARCHAR(255))   BEGIN

INSERT INTO usuarios (rol_id, nombre, correo, contrasena)
    VALUES (_rol_id, _nombre, _correo, _contrasena);

END$$

DROP PROCEDURE IF EXISTS `SP_LOGIN_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOGIN_USUARIO` (IN `_correo` VARCHAR(100))   BEGIN

SELECT usuario_id, rol_id, nombre, correo, contrasena FROM usuarios
WHERE correo = _correo
LIMIT 1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `competencias`
--

DROP TABLE IF EXISTS `competencias`;
CREATE TABLE `competencias` (
  `competencias_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `competencias` varchar(150) NOT NULL,
  `tipo` enum('BLANDA','CORPORATIVA') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `competencias_preguntas`
--

DROP TABLE IF EXISTS `competencias_preguntas`;
CREATE TABLE `competencias_preguntas` (
  `competencia_pregunta_id` int(11) NOT NULL,
  `competencias_id` int(11) NOT NULL,
  `evaluaciones_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

DROP TABLE IF EXISTS `evaluaciones`;
CREATE TABLE `evaluaciones` (
  `evaluaciones_id` int(11) NOT NULL,
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
  `evaluacion_realizada_id` int(11) NOT NULL,
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
  `objetivo_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `objetivo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `objetivos_evaluacion`
--

INSERT INTO `objetivos_evaluacion` (`objetivo_id`, `rol_id`, `objetivo`) VALUES
(1, 1, 'Apoyar a la Dirección de Gestión Humana en las actividades que implican el bienestar, desarrollo y contratación del personal.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(2, 2, 'Velar por la Seguridad e integridad de los colaboradores, así como apoyar el proceso de sistema integrado de gestión en el cumplimiento de metas propuestas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(3, 3, 'Velar por mantener el inventario del almacén con la información confiable y el orden requerido, para un buen manejo de existencias, con el fin de dar cumplimiento en el proceso productivo y no afectar al mismo.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(4, 4, 'Apoyar el proceso de compras con el fin de que la cadena de suministro de la empresa sea fluida, ágil y eficaz, cumpliendo con los parámetros de calidad y las políticas de la empresa.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(5, 5, 'Apoyar el proceso de compras con el fin de que la cadena de suministro de la empresa sea fluida, ágil y eficaz, cumpliendo con los parámetros de calidad y las políticas de la empresa.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(6, 6, 'Realizar la facturación de las ventas de los productos de calzado 70 cumplimiendo con las políticas del proceso.\r\n\r\nApoyar al área de logística en las actividades requeridas que sean de la naturaleza del cargo.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(7, 7, 'Apoyar los procesos contables de la compañía, realizar asientos de las diferentes cuentas de gastos, servicios y arrendamientos, revisando, clasificando y registrando los documentos a fin de mantener actualizados los movimientos contables que se realizan en la empresa y mantener actualizados los archivos del área.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(8, 8, 'Verificar la calidad del producto en el proceso productivo, contribuyendo a la disminución del producto no conforme\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(9, 9, 'Garantizar y mantener el sistema de gestión integral de la compañía, seguridad y salud en el trabajo, gestión Ambiental y Calidad, cumpliendo con las políticas y los procedimientos establecidos en los procesos. \r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(10, 10, 'Garantizar y mantener el sistema de gestión integral de la compañía, seguridad y salud en el trabajo, gestión Ambiental y Calidad, cumpliendo con las políticas y los procedimientos establecidos en los procesos.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(11, 11, 'Garantizar que la cadena de suministro de la empresa sea fluida, ágil y eficaz; siempre coordinado con el área de producción y finanzas, para así poder escoger alternativas con disponibilidad de entrega, buena calidad y precio de productos de terceros y servicios internos.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(12, 12, 'Analizar, Organizar y Ejecutar las tareas relacionadas el análisis de cuentas contables, para certificar la exactitud de los saldos de las cuentas que integran los Estados Financieros; así mismo proporcionar y gestionar de manera eficiente y confiable la información resultante de los registros contables, nómina y seguridad social, garantizando que se realicen en los tiempos establecidos, de acuerdo con la normatividad legal vigente y las políticas definidas por la compañía. adscrita con el fin de analizar, sistematizar y presentar la información de carácter contable y financiero, que permita la correcta toma de decisiones confiables a la empresa\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(13, 13, 'Velar por los procesos de cobro y recaudo de la cartera a través de la generación y análisis de la información, y el desarrollo de acciones de cobranza y crédito que permitan minimizar el riesgo crediticio, para cumplir con los niveles de cartera establecidos por la empresa.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(14, 14, 'Analizar y Organizar la estructura de costos de la organización, así como recolectar, sistematizar y organizar de forma veraz la información de los procesos productivos de la organización de tal manera que se puedan tomar decisiones económicas y financieras oportunamente.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(15, 15, 'Asegurar el abastecimiento de materias primas e insumos evitando agotados en el stock,utilizando la herramienta asigna para el análisis y gestión de compra, cumpliendo con la calidad, precio  y plazos de entrega, buscando bajar los costos para mejorar la rentabilidad y minimizar el riesgo en las operaciones.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(16, 16, 'Dirigir y administrar eficiente y eficazmente los recursos financieros de la empresa, con la finalidad de contribuir al logro de los objetivos, garantizando el cumplimiento oportuno de las obligaciones laborales, legales, tributarias y económicas, con estricto apego a la normatividad.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(17, 17, 'Planear, dirigir y coordinar las actividades de la fuerza de ventas y los planes de comercialización y mercadeo; para lograr el posicionamiento de los productos y la empresa, con base a las políticas establecidas por la Gerencia General para la promoción, distribución y venta, con el fin de lograr las metas de presupuestos.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(18, 18, 'Gestionar las actividades del área comercial bajo el direccionamiento de la Dirección Comercial, aportando al crecimiento de las ventas, apoyar las nuevas estrategias comerciales con miras al cumplimiento de los presupuestos de venta y la fidelización de los clientes.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(19, 19, 'Promover el portafolio de productos a través del punto de venta y los canales digitales en pro de cumplir con los presupuestos de ventas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(20, 20, 'Administrar el punto de venta, cumpliendo las metas de ventas establecidas, asegurando el correcto manejo del inventario y garantizando óptimas condiciones de infraestructura del local.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(21, 21, 'Comercialización y distribución de los productos de calzado 70,garantizando un cierre de ventas efectivos que satisfagan las necesidades del cliente y la fidelización con la marca, así mismo velando por el recaudo en los tiempos establecidos durante la negociación en bien del crecimiento y la sostenibilidad de la compañía.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(22, 22, 'Dirigir, planificar, coordinar y liderar el desarrollo de las personas que laboran en la empresa, manteniendo y mejorando las relaciones y laborales entre la direccion y los colaboradores, actuando siempre en funcion de la estrategia y las necesidades de la organización, equilibrando y armonizando los intereses tanto de los colaboradores como de los empleadores, pensado siempre en la productividad de la empresa y en que exista un buen clima laboral.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(23, 23, 'Dirigir y gestionar los recursos de las áreas de producción y mantenimiento, garantizando la correcta planeación de las órdenes de producción, con el objetivo de cumplir los plazos de entrega manteniendo la calidad estipulada. normatividad.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(24, 24, 'Programar, Planear y hacer seguimiento a la ejecución del programa de producción de la planta, gestionar de manera directa con los líderes de las diferentes áreas del proceso productivo todas las novedades que se presenten con los recursos (Mano de obra, máquinas y MP), gestionar la eficiencia de los procesos buscando consolidar indicadores de resultado y velar por la optimización de todos los procesos, Velar por la calidad del producto y la generación de información oportuna y veraz en pro de tomar decisiones acertadas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(25, 25, 'Estandarizar todos los procesos de producción en la organización mediante el uso de metodologías agiles. Llevar el control estadístico de algunos procesos productivos realizando análisis de indicadores y reportando los resultados a la Dirección y/o Coordinación de producción.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(26, 26, 'Liderar el proceso a su cargo, gestionando los recursos (Mano de obra, Materia Prima, Equipos), a través del correcto desarrollo del programa de producción, el control de los consumos de la Materia Prima la optimización de los procesos productivos, la calidad del producto y la seguridad de las personas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(27, 27, 'Liderar el proceso a su cargo, gestionando los recursos (Mano de obra, Materia Prima, Equipos), a través del correcto desarrollo del programa de producción, el control de los consumos de la Materia Prima la optimización de los procesos productivos, la calidad del producto y la seguridad de las personas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(28, 28, 'Liderar el proceso a su cargo, gestionando los recursos (Mano de obra, Materia Prima, Equipos), a través del correcto desarrollo del programa de producción, el control de los consumos de la Materia Prima la optimización de los procesos productivos, la calidad del producto y la seguridad de las personas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(29, 29, 'Liderar el proceso a su cargo, gestionando los recursos (Mano de obra, Materia Prima, Equipos), a través del correcto desarrollo del programa de producción, el control de los consumos de la Materia Prima la optimización de los procesos productivos, la calidad del producto y la seguridad de las personas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(30, 30, 'Liderar el proceso a su cargo, gestionando los recursos (Mano de obra, Materia Prima, Equipos), a través del correcto desarrollo del programa de producción, el control de los consumos de la Materia Prima la optimización de los procesos productivos, la calidad del producto y la seguridad de las personas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(31, 31, 'Liderar el proceso a su cargo, gestionando los recursos (Mano de obra, Materia Prima, Equipos), a través del correcto desarrollo del programa de producción, el control de los consumos de la Materia Prima la optimización de los procesos productivos, la calidad del producto y la seguridad de las personas.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1'),
(32, 32, 'Gestionar las actividades necesarias del proceso de guarnecidad externa, garantizando la entrega y salida del producto, llevando la información correcta que permita tomar decisiones a la alta dirección.\r\n\r\nCALIFICACION: Siempre: 5 - Aveces: 3 - Nunca: 1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos_preguntas`
--

DROP TABLE IF EXISTS `objetivos_preguntas`;
CREATE TABLE `objetivos_preguntas` (
  `objetivo_pregunta_id` int(11) NOT NULL,
  `objetivo_id` int(11) NOT NULL,
  `evaluaciones_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

DROP TABLE IF EXISTS `respuestas`;
CREATE TABLE `respuestas` (
  `respuestas_id` int(11) NOT NULL,
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
  `rol_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `nombre`) VALUES
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
  `usuario_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `rol_id`, `nombre`, `correo`, `contrasena`) VALUES
(1, 33, 'gian carlos', 'practicanteadm@calzado70.com', '$2b$10$byXvBZvFeKjwtr7yn8jvBOeGS8jXjq2qKrE.lhzPKa1Rcz9.1.MxO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valores_respuesta`
--

DROP TABLE IF EXISTS `valores_respuesta`;
CREATE TABLE `valores_respuesta` (
  `valores_id` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `valor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valores_respuesta`
--

INSERT INTO `valores_respuesta` (`valores_id`, `descripcion`, `valor`) VALUES
(1, 'Siempre', 5),
(2, 'A veces', 3),
(3, 'Nunca', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `competencias`
--
ALTER TABLE `competencias`
  ADD PRIMARY KEY (`competencias_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `competencias_preguntas`
--
ALTER TABLE `competencias_preguntas`
  ADD PRIMARY KEY (`competencia_pregunta_id`),
  ADD UNIQUE KEY `unique_competencia_evaluacion` (`competencias_id`,`evaluaciones_id`),
  ADD KEY `evaluaciones_id` (`evaluaciones_id`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`evaluaciones_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `evaluaciones_realizadas`
--
ALTER TABLE `evaluaciones_realizadas`
  ADD PRIMARY KEY (`evaluacion_realizada_id`);

--
-- Indices de la tabla `objetivos_evaluacion`
--
ALTER TABLE `objetivos_evaluacion`
  ADD PRIMARY KEY (`objetivo_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `objetivos_preguntas`
--
ALTER TABLE `objetivos_preguntas`
  ADD PRIMARY KEY (`objetivo_pregunta_id`),
  ADD UNIQUE KEY `unique_objetivo_evaluacion` (`objetivo_id`,`evaluaciones_id`),
  ADD KEY `evaluaciones_id` (`evaluaciones_id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`respuestas_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `evaluacion_id` (`evaluacion_id`),
  ADD KEY `evaluacion_realizada_id` (`evaluacion_realizada_id`),
  ADD KEY `valor_respuesta_id` (`valor_respuesta_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `valores_respuesta`
--
ALTER TABLE `valores_respuesta`
  ADD PRIMARY KEY (`valores_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `competencias`
--
ALTER TABLE `competencias`
  MODIFY `competencias_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `competencias_preguntas`
--
ALTER TABLE `competencias_preguntas`
  MODIFY `competencia_pregunta_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `evaluaciones_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluaciones_realizadas`
--
ALTER TABLE `evaluaciones_realizadas`
  MODIFY `evaluacion_realizada_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `objetivos_evaluacion`
--
ALTER TABLE `objetivos_evaluacion`
  MODIFY `objetivo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `objetivos_preguntas`
--
ALTER TABLE `objetivos_preguntas`
  MODIFY `objetivo_pregunta_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `respuestas_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `valores_respuesta`
--
ALTER TABLE `valores_respuesta`
  MODIFY `valores_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `competencias`
--
ALTER TABLE `competencias`
  ADD CONSTRAINT `competencias_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `competencias_preguntas`
--
ALTER TABLE `competencias_preguntas`
  ADD CONSTRAINT `competencias_preguntas_ibfk_1` FOREIGN KEY (`competencias_id`) REFERENCES `competencias` (`competencias_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `competencias_preguntas_ibfk_2` FOREIGN KEY (`evaluaciones_id`) REFERENCES `evaluaciones` (`evaluaciones_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `objetivos_evaluacion`
--
ALTER TABLE `objetivos_evaluacion`
  ADD CONSTRAINT `objetivos_evaluacion_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `objetivos_preguntas`
--
ALTER TABLE `objetivos_preguntas`
  ADD CONSTRAINT `objetivos_preguntas_ibfk_1` FOREIGN KEY (`objetivo_id`) REFERENCES `objetivos_evaluacion` (`objetivo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `objetivos_preguntas_ibfk_2` FOREIGN KEY (`evaluaciones_id`) REFERENCES `evaluaciones` (`evaluaciones_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`),
  ADD CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`evaluaciones_id`),
  ADD CONSTRAINT `respuestas_ibfk_3` FOREIGN KEY (`evaluacion_realizada_id`) REFERENCES `evaluaciones_realizadas` (`evaluacion_realizada_id`),
  ADD CONSTRAINT `respuestas_ibfk_4` FOREIGN KEY (`valor_respuesta_id`) REFERENCES `valores_respuesta` (`valores_id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
