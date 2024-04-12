-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-04-2024 a las 21:21:18
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `visioncorp`
CREATE DATABASE IF NOT EXISTS visioncorp;

-- Usar la base de datos visioncorp
USE visioncorp;
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento`
--

CREATE TABLE `documento` (
  `DocumentoID` int(11) NOT NULL,
  `NombreDocumento` varchar(255) DEFAULT NULL,
  `RutaDocumento` varchar(255) NOT NULL,
  `FechaCarga` varchar(255) NOT NULL,
  `EmpleadoID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `EmpleadoID` int(11) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Apellido` varchar(255) DEFAULT NULL,
  `Edad` int(11) DEFAULT NULL,
  `CorreoElectronico` varchar(255) DEFAULT NULL,
  `Telefono` varchar(255) DEFAULT NULL,
  `Puesto` varchar(255) DEFAULT NULL,
  `Departamento` varchar(255) DEFAULT NULL,
  `FechaIngreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



--
-- Estructura de tabla para la tabla `historialsalario`
--

CREATE TABLE `historialsalario` (
  `id` int(11) NOT NULL,
  `SalarioDiario` decimal(10,2) DEFAULT NULL,
  `Aguinaldo` int(2) DEFAULT NULL,
  `PrimaVacacional` decimal(3,2) DEFAULT NULL,
  `diasVacaciones` int(2) DEFAULT NULL,
  `SalarioIntegrado` decimal(10,2) DEFAULT NULL,
  `FechaActualizacion` date DEFAULT NULL,
  `EmpleadoID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Estructura de tabla para la tabla `salarios`
--

CREATE TABLE `salarios` (
  `id` int(11) NOT NULL,
  `SalarioDiario` decimal(10,2) DEFAULT NULL,
  `Aguinaldo` int(2) DEFAULT NULL,
  `PrimaVacacional` decimal(3,2) DEFAULT NULL,
  `diasVacaciones` int(2) DEFAULT NULL,
  `SalarioIntegrado` decimal(10,2) DEFAULT NULL,
  `FechaActualizacion` date DEFAULT NULL,
  `EmpleadoID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Estructura de tabla para la tabla `usuarioadministrador`
--

CREATE TABLE `usuarioadministrador` (
  `UsuarioID` int(11) NOT NULL,
  `NombreUsuario` varchar(255) DEFAULT NULL,
  `correoElectronico` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`DocumentoID`),
  ADD KEY `EmpleadoID` (`EmpleadoID`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`EmpleadoID`);

--
-- Indices de la tabla `historialsalario`
--
ALTER TABLE `historialsalario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `EmpleadoID` (`EmpleadoID`);

--
-- Indices de la tabla `salarios`
--
ALTER TABLE `salarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `EmpleadoID` (`EmpleadoID`);

--
-- Indices de la tabla `usuarioadministrador`
--
ALTER TABLE `usuarioadministrador`
  ADD PRIMARY KEY (`UsuarioID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documento`
--
ALTER TABLE `documento`
  MODIFY `DocumentoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `EmpleadoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `historialsalario`
--
ALTER TABLE `historialsalario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `salarios`
--
ALTER TABLE `salarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `usuarioadministrador`
--
ALTER TABLE `usuarioadministrador`
  MODIFY `UsuarioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documento`
--
ALTER TABLE `documento`
  ADD CONSTRAINT `documento_ibfk_1` FOREIGN KEY (`EmpleadoID`) REFERENCES `empleado` (`EmpleadoID`);

--
-- Filtros para la tabla `historialsalario`
--
ALTER TABLE `historialsalario`
  ADD CONSTRAINT `historialsalario_ibfk_1` FOREIGN KEY (`EmpleadoID`) REFERENCES `empleado` (`EmpleadoID`);

--
-- Filtros para la tabla `salarios`
--
ALTER TABLE `salarios`
  ADD CONSTRAINT `salarios_ibfk_1` FOREIGN KEY (`EmpleadoID`) REFERENCES `empleado` (`EmpleadoID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
