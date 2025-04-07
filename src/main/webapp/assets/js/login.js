document.addEventListener('DOMContentLoaded', function() {
    const loginNav = document.getElementById('loginNav');
    const registerNav = document.getElementById('registerNav');
    const navIndicator = document.querySelector('.nav-indicator');
    const loginForm = document.getElementById('luxuryLoginForm');
    const registerForm = document.getElementById('luxuryRegisterForm');
    const switchToLoginLink = document.getElementById('switchToLoginLink');
    
    function showLoginForm() {
        loginNav.classList.add('active');
        registerNav.classList.remove('active');
        navIndicator.style.transform = 'translateX(0)';
        registerForm.classList.remove('active');
        setTimeout(() => loginForm.classList.add('active'), 300);
    }
    
    function showRegisterForm() {
        loginNav.classList.remove('active');
        registerNav.classList.add('active');
        navIndicator.style.transform = 'translateX(100%)';
        loginForm.classList.remove('active');
        setTimeout(() => registerForm.classList.add('active'), 300);
    }
    
    loginNav.addEventListener('click', showLoginForm);
    registerNav.addEventListener('click', showRegisterForm);
    switchToLoginLink.addEventListener('click', function(e) {
        e.preventDefault();
        showLoginForm();
    });
    
    const passwordToggles = document.querySelectorAll('.password-toggle');
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            const passwordInput = this.closest('.password-group').querySelector('input');
            const icon = this.querySelector('i');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    });
    
    const fileInput = document.getElementById('luxuryProfileImage');
    const avatarPreview = document.querySelector('.avatar-preview');
    const profilePreview = document.querySelector('.profile-preview');
    const defaultAvatar = document.querySelector('.default-avatar');
    const uploadText = document.querySelector('.avatar-upload-text');

    if (fileInput) {
        fileInput.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    profilePreview.src = e.target.result;
                    profilePreview.classList.add('visible');
                    defaultAvatar.style.display = 'none';
                    uploadText.textContent = 'Change Photo';
                };
                reader.readAsDataURL(file);
            }
        });
    }
});