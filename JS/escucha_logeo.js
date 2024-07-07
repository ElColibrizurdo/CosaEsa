(function() {
    const originalSetItem = sessionStorage.setItem;
    sessionStorage.setItem = function(key, value) {
        const event = new Event('sessionStorageChange');
        event.key = key;
        event.newValue = value;
        window.dispatchEvent(event);
        originalSetItem.apply(this, arguments);
    };
})();

window.addEventListener('sessionStorageChange', (event) => {
    console.log('Cambio detectado en sessionStorage');
    console.log(`Clave: ${event.key}`);
    console.log(`Nuevo valor: ${event.newValue}`);

    const token = parseJwt(event.newValue)

    const perfil = document.getElementById('perfil')
    perfil.textContent = perfil.user.name
});

function parseJwt (token) {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
    console.log(jsonPayload);
    return JSON.parse(jsonPayload);
}

