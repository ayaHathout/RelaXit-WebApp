document.addEventListener('DOMContentLoaded', function() {
    console.log("login.js is loaded and running");

    console.log("DOM loaded, checking Google API...");
    if (typeof google !== 'undefined' && google.accounts) {
        console.log("Google API is loaded!");
    } else {
        console.log("Google API is NOT loaded.");
    }

    const loginNav = document.getElementById('loginNav');
    const registerNav = document.getElementById('registerNav');
    const navIndicator = document.querySelector('.nav-indicator');
    const loginForm = document.getElementById('luxuryLoginForm');
    const registerForm = document.getElementById('luxuryRegisterForm');
    const switchToLoginLink = document.getElementById('switchToLoginLink');
    const registerBtn = document.getElementById('registerBtn');

    const inputs = {
        file: document.getElementById('luxuryProfileImage'),
        fullName: document.getElementById('luxuryFullName'),
        email: document.getElementById('luxuryRegEmail'),
        password: document.getElementById('luxuryRegPassword'),
        birthdate: document.getElementById('luxuryBirthdate'),
        profession: document.getElementById('luxuryProfession'),
        residence: document.getElementById('luxuryResidence'),
        interests: document.getElementById('luxuryInterests')
    };

    const errors = {
        file: document.getElementById('profileImageError'),
        fullName: document.getElementById('fullNameError'),
        email: document.getElementById('emailError'),
        password: document.getElementById('passwordError'),
        birthdate: document.getElementById('birthdateError'),
        profession: document.getElementById('professionError'),
        residence: document.getElementById('residenceError'),
        interests: document.getElementById('interestsError')
    };

    const regex = {
        name: /^[a-zA-Z\s]+$/,
        email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
        password: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$/,
        profession: /^[a-zA-Z\s\d]+$/,
        residence: /^[a-zA-Z0-9\s,.-]+$/,
        interests: /^[a-zA-Z\s,]+$/
    };

    let debounceTimeout;

    function showLoginForm() {
        loginNav.classList.add('active');
        registerNav.classList.remove('active');
        navIndicator.style.transform = 'translateX(0)';
        registerForm.classList.remove('active');
        setTimeout(() => {
            loginForm.classList.add('active');
            initializePasswordToggles();
        }, 300);
    }
    
    function showRegisterForm() {
        loginNav.classList.remove('active');
        registerNav.classList.add('active');
        navIndicator.style.transform = 'translateX(100%)';
        loginForm.classList.remove('active');
        setTimeout(() => {
            registerForm.classList.add('active');
            initializePasswordToggles();
        }, 300);
    }

    // إضافة الـ event listeners للـ navigation buttons
    loginNav.addEventListener('click', (e) => {
        e.preventDefault();
        showLoginForm();
    });

    registerNav.addEventListener('click', (e) => {
        e.preventDefault();
        showRegisterForm();
    });

    switchToLoginLink.addEventListener('click', (e) => {
        e.preventDefault();
        showLoginForm();
    });

    function setError(element, message) {
        element.textContent = message;
        element.classList.remove('validation-success');
    }

    function setSuccess(element) {
        element.textContent = '';
        element.classList.add('validation-success');
    }

    function validateField(input, error, regex, requiredMessage, invalidMessage) {
        const value = input.value.trim();
        if (!value) {
            setError(error, requiredMessage);
            return false;
        } else if (regex && !regex.test(value)) {
            setError(error, invalidMessage);
            return false;
        }
        setSuccess(error);
        return true;
    }

    function validateBirthdate() {
        const value = inputs.birthdate.value;
        const today = new Date().toISOString().split('T')[0];
        if (!value) {
            setError(errors.birthdate, 'Birthdate is required');
            return false;
        } else if (value >= today) {
            setError(errors.birthdate, 'Birthdate must be in the past');
            return false;
        }
        setSuccess(errors.birthdate);
        return true;
    }

    async function validateEmail() {
        const value = inputs.email.value.trim();
        if (!value) {
            setError(errors.email, 'Email is required');
            return false;
        } else if (!regex.email.test(value)) {
            setError(errors.email, 'Invalid email format');
            return false;
        }
        try {
            const response = await fetch(`${window.contextPath}/checkEmail`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `email=${encodeURIComponent(value)}`
            });
            const data = await response.json();
            if (data.exists) {
                setError(errors.email, 'Email Already Taken ❌');
                return false;
            }
            setSuccess(errors.email);
            return true;
        } catch (error) {
            setError(errors.email, 'Error checking email');
            return false;
        }
    }

    function validateForm() {
        const isValid = (
            validateField(inputs.fullName, errors.fullName, regex.name, 'Full name is required', 'Only letters and spaces allowed') &&
            validateBirthdate() &&
            validateField(inputs.password, errors.password, regex.password, 'Password is required', 'At least 8 characters, 1 uppercase, 1 lowercase, 1 number') &&
            validateField(inputs.profession, errors.profession, regex.profession, 'Profession is required', 'Only letters, numbers, and spaces allowed') &&
            validateField(inputs.residence, errors.residence, regex.residence, 'Residence is required', 'Only letters, numbers, spaces, and basic punctuation allowed') &&
            (!inputs.interests.value.trim() || validateField(inputs.interests, errors.interests, regex.interests, '', 'Only letters, spaces, and commas allowed'))
        );
        registerBtn.disabled = !isValid;
        return isValid;
    }

    function initializePasswordToggles() {
        const passwordToggles = document.querySelectorAll('.password-toggle');
        console.log('Initializing toggles, found:', passwordToggles.length);
        passwordToggles.forEach(toggle => {
            toggle.removeEventListener('click', togglePassword);
            toggle.addEventListener('click', togglePassword);
        });
    }

    function togglePassword(e) {
        e.preventDefault();
        const toggle = e.currentTarget;
        const passwordGroup = toggle.closest('.password-group');
        const passwordInput = passwordGroup.querySelector('input');
        const icon = toggle.querySelector('i');
        console.log('Toggle clicked, current type:', passwordInput.type);
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
        console.log('New type:', passwordInput.type);
    }

    initializePasswordToggles();

    inputs.fullName.addEventListener('input', () => {
        validateField(inputs.fullName, errors.fullName, regex.name, 'Full name is required', 'Only letters and spaces allowed');
        validateForm();
    });

    inputs.email.addEventListener('input', function() {
        const value = this.value.trim();
        if (!value) {
            setError(errors.email, 'Email is required');
        } else if (!regex.email.test(value)) {
            setError(errors.email, 'Invalid email format');
        } else {
            clearTimeout(debounceTimeout);
            debounceTimeout = setTimeout(async () => {
                await validateEmail();
                validateForm();
            }, 300);
        }
        validateForm();
    });

    inputs.password.addEventListener('input', () => {
        validateField(inputs.password, errors.password, regex.password, 'Password is required', 'At least 8 characters, 1 uppercase, 1 lowercase, 1 number');
        validateForm();
    });

    inputs.birthdate.addEventListener('input', () => {
        validateBirthdate();
        validateForm();
    });

    inputs.profession.addEventListener('input', () => {
        validateField(inputs.profession, errors.profession, regex.profession, 'Profession is required', 'Only letters, numbers, and spaces allowed');
        validateForm();
    });

    inputs.residence.addEventListener('input', () => {
        validateField(inputs.residence, errors.residence, regex.residence, 'Residence is required', 'Only letters, numbers, spaces, and basic punctuation allowed');
        validateForm();
    });

    inputs.interests.addEventListener('input', () => {
        validateField(inputs.interests, errors.interests, regex.interests, '', 'Only letters, spaces, and commas allowed');
        validateForm();
    });

    inputs.file.addEventListener('change', function() {
        const file = this.files[0];
        if (file && !file.type.startsWith('image/')) {
            setError(errors.file, 'Only image files allowed');
        } else {
            setSuccess(errors.file);
            const reader = new FileReader();
            reader.onload = function(e) {
                document.querySelector('.profile-preview').src = e.target.result;
                document.querySelector('.profile-preview').classList.add('visible');
                document.querySelector('.default-avatar').style.display = 'none';
                document.querySelector('.avatar-upload-text').textContent = 'Change Photo';
            };
            reader.readAsDataURL(file);
        }
        validateForm();
    });

    registerForm.addEventListener('submit', async function(e) {
        e.preventDefault();
        console.log("Raw password before validation:", inputs.password.value);
        const emailValid = await validateEmail();
        const formValid = validateForm() && emailValid;
        if (formValid) {
            console.log("Register form submitting with email:", inputs.email.value, "password:", inputs.password.value);
            this.submit();
        } else {
            console.log("Validation failed. Errors:");
            for (const key in errors) {
                if (errors[key].textContent) {
                    console.log(`${key}: ${errors[key].textContent}`);
                }
            }
        }
    });

    window.handleCredentialResponse = function(response) {
        console.log("Google Sign-In triggered, ID Token: " + response.credential);
        const base64Url = response.credential.split('.')[1];
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));
        const payload = JSON.parse(jsonPayload);
        const email = payload.email;
        const name = payload.name;
    
        console.log("Email: " + email + ", Name: " + name);
    
        fetch(window.contextPath + '/googleLogin', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'idToken=' + encodeURIComponent(response.credential) + 
                  '&email=' + encodeURIComponent(email) + 
                  '&name=' + encodeURIComponent(name)
        })
        .then(response => {
            console.log("Server response:", response);
            return response.json();
        })
        .then(data => {
            console.log("Response data:", data);
            if (data.success) {
                window.location.href = data.redirectUrl;
            } else {
                alert('Google Login Failed: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error during Google login:', error);
        });
    };
});