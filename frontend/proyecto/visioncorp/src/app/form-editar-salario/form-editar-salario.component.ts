import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ApiService } from '../api.service';
import { Salario } from '../salarios';

@Component({
  selector: 'app-form-editar-salario',
  templateUrl: './form-editar-salario.component.html',
  styleUrl: './form-editar-salario.component.css'
})
export class FormEditarSalarioComponent {

  id = this.route.snapshot.params['id'];
  formulario: FormGroup;
  currentDate: Date = new Date();
  salario!: Salario;


  constructor(private fb: FormBuilder, private apiService: ApiService, private route: ActivatedRoute, private router: Router) {
    this.formulario = this.fb.group({
      salarioDiario: ['', [Validators.required, Validators.pattern(/^\d+(\.\d{2})?$/)]],
      aguinaldo: ['', [Validators.required, Validators.pattern(/^([0-9])*$/)]],
      primaVacacional: ['', [Validators.required, Validators.pattern(/^\d+(\.\d{2})?$/)]],
      diasVacaciones: ['', [Validators.required, Validators.pattern(/^([0-9])*$/)]],
      salarioIntegrado: [''],
      fechaActualizacion: [this.obtenerFechaActual(), Validators.required]
    });
  }

  ngOnInit() {
    this.route.params.subscribe(params => {
      const id = params['id'];
      this.apiService.obtenerSalarioPorId(id).subscribe(salario => {
        this.salario = salario;
        this.formulario.patchValue({
          salarioDiario: salario.salarioDiario,
          aguinaldo: salario.aguinaldo,
          primaVacacional: salario.primaVacacional,
          diasVacaciones: salario.diasVacaciones,
          salarioIntegrado: salario.salarioIntegrado
        });
      });

    });
  }

  editarSalario() {
    if (this.formulario.valid) {
      const id = this.route.snapshot.params['ids'];
      const idEmpleado = this.route.snapshot.params['id']
      console.log(id);

      const salarioDiario = parseFloat(this.formulario.value.salarioDiario);
      const aguinaldo = parseInt(this.formulario.value.aguinaldo);
      const primaVacacional = parseFloat(this.formulario.value.primaVacacional);
      const diasVacaciones = parseInt(this.formulario.value.diasVacaciones);
      let salarioIntegrado = salarioDiario * ((aguinaldo/365)+((diasVacaciones*primaVacacional)/365)+1);

      const salarioEditado = {
        id: id,
        EmpleadoID: idEmpleado,
        fechaIngreso: this.formulario.value.fechaIngreso,
        salarioDiario: salarioDiario,
        aguinaldo: aguinaldo,
        primaVacacional: primaVacacional,
        diasVacaciones: diasVacaciones,
        salarioIntegrado: salarioIntegrado
      };



      this.apiService.editarSalario(id, salarioEditado).subscribe({
        next: (response: any) => {
          console.log(response.mensaje);
          this.router.navigate(['/salarios']);
        },
        error: (error) => {
          console.error('Error al editar el empleado:', error);
        }
      });
    }
  }

  obtenerFechaActual(): string {
    const fechaActual = new Date();
    const mes = fechaActual.getMonth() + 1 < 10 ? '0' + (fechaActual.getMonth() + 1) : fechaActual.getMonth() + 1;
    const dia = fechaActual.getDate() < 10 ? '0' + fechaActual.getDate() : fechaActual.getDate();
    return `${fechaActual.getFullYear()}-${mes}-${dia}`;
  }
}
