<?php

include_once("db_conexion.php");

$AngularData = file_get_contents("php://input");
if(isset($AngularData) && !empty($AngularData)){
    
    $request = json_decode($AngularData);

    $EmpleadoID = mysqli_real_escape_string($mysqli, trim($_GET['id']));
    $salarioDiario = mysqli_real_escape_string($mysqli, trim($request->salarioDiario));
    $aguinaldo = mysqli_real_escape_string($mysqli, trim($request->aguinaldo));
    $primaVacacional = mysqli_real_escape_string($mysqli, trim($request->primaVacacional));
    $diasVacaciones = mysqli_real_escape_string($mysqli, trim($request->diasVacaciones));
    $salarioIntegrado = mysqli_real_escape_string($mysqli, trim($request->salarioIntegrado));
    $fechaActualizacion = mysqli_real_escape_string($mysqli, trim($request->fechaActualizacion));

    $sqlSalarios = "INSERT INTO salarios (EmpleadoID, SalarioDiario, Aguinaldo, PrimaVacacional, DiasVacaciones, SalarioIntegrado, FechaActualizacion) 
                    VALUES (?, ?, ?, ?, ?, ?)";
    
    $stmtSalarios = mysqli_prepare($mysqli, $sqlSalarios);
    mysqli_stmt_bind_param($stmtSalarios, "idddss", $EmpleadoID, $salarioDiario, $aguinaldo, $primaVacacional, $diasVacaciones,$salarioIntegrado, $fechaActualizacion);
    $resultadoSalarios = mysqli_stmt_execute($stmtSalarios);

    
    $sqlHistorial = "INSERT INTO historialSalario (EmpleadoID, SalarioDiario, Aguinaldo, PrimaVacacional, DiasVacaciones, SalarioIntegrado, FechaActualizacion) 
                     VALUES (?, ?, ?, ?, ?, ?)";
    
    $stmtHistorial = mysqli_prepare($mysqli, $sqlHistorial);
    mysqli_stmt_bind_param($stmtHistorial, "idddss", $EmpleadoID, $salarioDiario, $aguinaldo, $primaVacacional, $diasVacaciones, $salarioIntegrado, $fechaActualizacion);
    $resultadoHistorial = mysqli_stmt_execute($stmtHistorial);

    if ($resultadoSalarios && $resultadoHistorial) {
        echo json_encode(['mensaje' => 'Registro creado con éxito']);
    } else {
        echo json_encode(['mensaje' => 'Error al crear el registro']);
    }

    mysqli_stmt_close($stmtSalarios);
    mysqli_stmt_close($stmtHistorial);
    mysqli_close($mysqli);
}

?>

