function EscuchaLogeo() {
    
    fetch('/protected/', {
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        }
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
        
        const nombre = document.getElementById('nombre-usuario')
        nombre.textContent = data.name + ' ' + data.apellido
    })
}

if (localStorage.getItem('token')) {
    
    EscuchaLogeo()
}