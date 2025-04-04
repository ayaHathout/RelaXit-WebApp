document.addEventListener('DOMContentLoaded', function() {
    // Form navigation
    const loginNav = document.getElementById('loginNav');
    const registerNav = document.getElementById('registerNav');
    const navIndicator = document.querySelector('.nav-indicator');
    const loginForm = document.getElementById('luxuryLoginForm');
    const registerForm = document.getElementById('luxuryRegisterForm');
    const switchToLoginLink = document.getElementById('switchToLoginLink');
    
    // Switch to login form
    function showLoginForm() {
        loginNav.classList.add('active');
        registerNav.classList.remove('active');
        navIndicator.style.transform = 'translateX(0)';
        
        registerForm.classList.remove('active');
        setTimeout(() => {
            loginForm.classList.add('active');
        }, 300);
    }
    
    // Switch to register form
    function showRegisterForm() {
        loginNav.classList.remove('active');
        registerNav.classList.add('active');
        navIndicator.style.transform = 'translateX(100%)';
        
        loginForm.classList.remove('active');
        setTimeout(() => {
            registerForm.classList.add('active');
        }, 300);
    }
    
    // Event listeners for navigation
    loginNav.addEventListener('click', showLoginForm);
    registerNav.addEventListener('click', showRegisterForm);
    switchToLoginLink.addEventListener('click', function(e) {
        e.preventDefault();
        showLoginForm();
    });
    
    // Password toggle functionality
    const passwordToggles = document.querySelectorAll('.password-toggle');
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            const passwordInput = this.closest('.password-group').querySelector('input');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
                
                this.style.animation = 'pulse 0.5s ease';
                setTimeout(() => {
                    this.style.animation = '';
                }, 500);
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    });
    
    // Avatar upload functionality
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
                    profilePreview.classList.add('visible'); // بيظهر الصورة
                    defaultAvatar.style.display = 'none'; // بيخفي الأيقونة الافتراضية
                    uploadText.textContent = 'Change Photo';
                    
                    // إضافة الأنيميشن
                    avatarPreview.style.animation = 'avatarPulse 1s ease, bounceIn 0.6s ease';
                    setTimeout(() => {
                        avatarPreview.style.animation = 'avatarPulse 3s infinite';
                    }, 1000);
                };
                reader.readAsDataURL(file);
            } else {
                profilePreview.classList.remove('visible');
                defaultAvatar.style.display = 'flex';
                uploadText.textContent = 'Choose Profile Photo';
                avatarPreview.style.animation = '';
            }
        });
    }

    /* Add keyframes dynamically */
    const styleSheet = document.createElement('style');
    styleSheet.textContent = `
        @keyframes bounceIn {
            0% { transform: scale(0.8); opacity: 0; }
            60% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); }
        }
    `;
    document.head.appendChild(styleSheet);
    
    // Initialize material inputs
    const materialInputs = document.querySelectorAll('.form-group input');
    materialInputs.forEach(input => {
        if (input.value) {
            const label = input.nextElementSibling;
            if (label && label.tagName === 'LABEL') {
                label.classList.add('active');
            }
        }
        
        if (input.type === 'date') {
            input.addEventListener('focus', function() {
                const label = document.querySelector(`label[for="${this.id}"]`);
                if (label) label.classList.add('active');
            });
            
            input.addEventListener('blur', function() {
                const label = document.querySelector(`label[for="${this.id}"]`);
                if (label && !this.value) label.classList.remove('active');
            });
        }
    });
    
    // Form submission handling
    const forms = document.querySelectorAll('.auth-form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const submitButton = this.querySelector('button[type="submit"]');
            const originalContent = submitButton.innerHTML;
            
            submitButton.disabled = true;
            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            
            setTimeout(() => {
                submitButton.disabled = false;
                submitButton.innerHTML = originalContent;
                
                console.log('Form submitted:', this.id);
                
                if (this.id === 'luxuryLoginForm') {
                    window.location.href = 'dashboard.html';
                }
                
                if (this.id === 'luxuryRegisterForm') {
                    showLoginForm();
                    if (fileInput) {
                        fileInput.value = '';
                        profilePreview.classList.remove('visible');
                        defaultAvatar.style.display = 'flex';
                        uploadText.textContent = 'Choose Profile Photo';
                        avatarPreview.style.animation = '';
                    }
                }
            }, 1500);
        });
    });
});