import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../api.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-form-crear-salario',
  templateUrl: './form-crear-salario.component.html',
  styleUrl: './form-crear-salario.component.css'
})
export class FormCrearSalarioComponent {

  formulario: FormGroup;
  currentDate: Date = new Date();
  id = this.route.snapshot.params['id'];


  constructor(private fb: FormBuilder, private apiService: ApiService,private route: ActivatedRoute, private router: Router) {
    this.formulario = this.fb.group({
        salarioDiario: ['', [Validators.required, Validators.pattern(/^\d+(\.\d{2})?$/)]],
        aguinaldo: ['', [Validators.required, Validators.pattern(/^([0-9])*$/)]],
        primaVacacional: ['', [Validators.required, Validators.pattern(/^\d+(\.\d{2})?$/)]],
        diasVacaciones: ['', [Validators.required, Validators.pattern(/^([0-9])*$/)]],
        salarioIntegrado: [''],
        fechaActualizacion: [this.obtenerFechaActual(), Validators.required]
    });

    
  }

  crearSalario(){
    if (this.formulario.valid) {
      
      const salarioDiario = parseFloat(this.formulario.value.salarioDiario);
      const aguinaldo = parseInt(this.formulario.value.aguinaldo);
      const primaVacacional = parseFloat(this.formulario.value.primaVacacional);
      const diasVacaciones = parseInt(this.formulario.value.diasVacaciones);
      let salarioIntegrado;

      if (!isNaN(salarioDiario) && !isNaN(aguinaldo) && !isNaN(primaVacacional) && !isNaN(diasVacaciones) ) {
        salarioIntegrado = salarioDiario * ((aguinaldo/365)+((diasVacaciones*primaVacacional)/365)+1);
        this.formulario.patchValue({
          salarioDiario: salarioDiario,
          aguinaldo: aguinaldo,
          primaVacacional: primaVacacional,
          diasVacaciones: diasVacaciones,
          salarioIntegrado: salarioIntegrado
        });
      }

      this.apiService.crearSalario(this.id, this.formulario.value).subscribe({
        next: (response: any) => {
          console.log(response.mensaje);
          this.router.navigate(['/salarios']); 
        },
        error: (error: any) => {
          console.log(this.formulario.value);
          console.error('Error al crear el salario del empleado:', error);
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
