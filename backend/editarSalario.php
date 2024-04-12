<?php

include_once("db_conexion.php");

$AngularData = file_get_contents("php://input");
if(isset($AngularData) && !empty($AngularData)){
    
    $request = json_decode($AngularData);

    $id = mysqli_real_escape_string($mysqli, trim($_GET['id']));
    $EmpleadoID = mysqli_real_escape_string($mysqli, trim($request->EmpleadoID));
    $salarioDiario = mysqli_real_escape_string($mysqli, trim($request->salarioDiario));
    $aguinaldo = mysqli_real_escape_string($mysqli, trim($request->aguinaldo));
    $primaVacacional = mysqli_real_escape_string($mysqli, trim($request->primaVacacional));
    $diasVacaciones = mysqli_real_escape_string($mysqli, trim($request->diasVacaciones));
    $salarioIntegrado = mysqli_real_escape_string($mysqli, trim($request->salarioIntegrado));
    $fechaActualizacion = mysqli_real_escape_string($mysqli, trim($request->fechaActualizacion));


    $sqlUpdate = "UPDATE salarios SET SalarioDiario = ?, Aguinaldo = ?, PrimaVacacional = ?, DiasVacaciones = ?, SalarioIntegrado = ?, FechaActualizacion = ? WHERE id = ?";
    $stmtUpdate = mysqli_prepare($mysqli, $sqlUpdate);
    mysqli_stmt_bind_param($stmtUpdate, "ddsssi", $salarioDiario, $aguinaldo, $primaVacacional, $diasVacaciones, $salarioIntegrado, $fechaActualizacion, $id);
    $resultadoUpdate = mysqli_stmt_execute($stmtUpdate);

    if ($resultadoUpdate) {
        $sqlHistorial = "INSERT INTO historialSalario (SalarioDiario, Aguinaldo, PrimaVacacional, DiasVacaciones, SalarioIntegrado, FechaActualizacion, EmpleadoID) 
                        SELECT SalarioDiario, Aguinaldo, PrimaVacacional, DiasVacaciones, SalarioIntegrado, FechaActualizacion, ? FROM salarios WHERE id = ?";
        $stmtHistorial = mysqli_prepare($mysqli, $sqlHistorial);
        mysqli_stmt_bind_param($stmtHistorial, "ii", $EmpleadoID, $id);
        $resultadoHistorial = mysqli_stmt_execute($stmtHistorial);

    if ($resultadoHistorial) {
            echo json_encode(['mensaje' => 'Registro actualizado y historial guardado con éxito']);
        } else {
            echo json_encode(['mensaje' => 'Error al guardar el historial']);
        }
    } else {
        echo json_encode(['mensaje' => 'Error al actualizar el registro']);
    }

    mysqli_stmt_close($stmtUpdate);
    mysqli_stmt_close($stmtHistorial);
    mysqli_close($mysqli);

}
?>


