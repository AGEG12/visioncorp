export class Salario {
    id: number;
    EmpleadoID: number;
    salarioDiario: number;
    aguinaldo: number;
    primaVacacional: number;
    diasVacaciones: number;
    salarioIntegrado: number;
    fechaIngreso: Date;
  
    constructor(id: number, EmpleadoID: number, salarioDiario: number, aguinaldo: number, primaVacacional: number, diasVacaciones: number, salarioIntegrado: number, fechaIngreso: Date) {
      this.id = id;
      this.EmpleadoID = EmpleadoID;
      this.salarioDiario = salarioDiario;
      this.aguinaldo = aguinaldo;
      this.primaVacacional = primaVacacional;
      this.diasVacaciones = diasVacaciones;
      this.salarioIntegrado = salarioIntegrado;
      this.fechaIngreso = fechaIngreso;
    }
  }
  