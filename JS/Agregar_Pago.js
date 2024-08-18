function Luhn(cardNumber) {

    const numerosDobles = []
    let suma = 0
    let multiplica = false
    
    const cardArray = cardNumber.value.split('')
    console.log(cardArray);

    for (let i = cardArray.length - 1; i >= 0; i--) {
        let element = parseInt(cardArray[i])
        
        if (multiplica) {
            element *= 2
            if (element > 9) {
                element -= 9
            }
        }

        suma += element
        multiplica = !multiplica
    }

    console.log('La suma ' + suma);
    
    const div = suma % 10

    if ((suma % 10) == 0) {
        
        console.log('La tarjeta es valida');
    } else {

        console.log('La tarjeta no es valida');
        
    }
}

function ComprobarExpiracion(year) {
    
        if (year.value >= 2024 && year.value <= 2050) {
            
            console.log('fecha valida');
            
        }
}

function ValidarDatos(btn) {

    console.log(btn);
    
    
    const card = document.getElementById('card')
    const anio = document.getElementById('fecha')
    const mes = document.getElementById('mes')
    const code = document.getElementById('code')
    const name = document.getElementById('name')

    console.log(card);
    console.log(anio);
    console.log(mes.value);
    console.log(code);
    console.log(name);
    
}

function validaNumericos(event) {
    if(event.charCode >= 48 && event.charCode <= 57){
      return true;
     }
     return false;        
}