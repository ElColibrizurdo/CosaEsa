async function AgregarPortada(params) {

    console.log(params.files[0]);
    

    const formData = new FormData()
    formData.append('image', params.files[0])
    
    fetch('/upload', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(result => {
        
        
    })

}   