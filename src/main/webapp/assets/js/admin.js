// admin.js
document.addEventListener('DOMContentLoaded', function () {
    // Sidebar toggle
    const sidebar = document.querySelector('.sidebar');
    const sidebarToggle = document.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function () {
            sidebar.classList.toggle('active');
        });
    }

    // AJAX search
    const searchForm = document.getElementById('searchForm');
    const searchInput = document.getElementById('searchInput');
    const clearButton = document.getElementById('clearButton');
    const usersTableBody = document.getElementById('usersTableBody');
    const feedback = document.getElementById('feedback');

    if (searchForm && searchInput && clearButton && usersTableBody && feedback) {
        // Debounce function
        function debounce(func, wait) {
            let timeout;
            return function (...args) {
                clearTimeout(timeout);
                timeout = setTimeout(() => func.apply(this, args), wait);
            };
        }

        // Search function
        function performSearch(searchTerm) {
            feedback.textContent = 'Loading...';
            feedback.classList.remove('d-none', 'alert-danger');
            feedback.classList.add('alert-info');

            const url = `${window.location.origin}/relaxit/admin/users/search?search=${encodeURIComponent(searchTerm)}`;
            console.log('Search URL:', url);

            fetch(url, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            })
                .then(response => {
                    console.log('Response Status:', response.status);
                    console.log('Response Headers:', response.headers.get('Content-Type'));
                    return response.text().then(text => {
                        console.log('Raw Response:', text);
                        if (!response.ok) {
                            throw new Error(`HTTP error! Status: ${response.status}, Response: ${text}`);
                        }
                        try {
                            return JSON.parse(text);
                        } catch (e) {
                            throw new Error(`JSON parse error: ${e.message}, Response: ${text}`);
                        }
                    });
                })
                .then(data => {
                    console.log('Parsed Data:', data);
                    usersTableBody.innerHTML = '';

                    if (data.length === 0) {
                        usersTableBody.innerHTML = '<tr><td colspan="8" class="text-center">No users found.</td></tr>';
                        feedback.classList.add('d-none');
                    } else {
                        data.forEach(user => {
                            const row = document.createElement('tr');
                            row.innerHTML = `
                                <td>${user.userId || ''}</td>
                                <td>${user.fullName || ''}</td>
                                <td>${user.email || ''}</td>
                                <td>${user.role || ''}</td>
                                <td>${user.job || ''}</td>
                                <td>${user.birthdate || ''}</td>
                                <td>${user.creditLimit != null ? user.creditLimit.toFixed(2) : ''}</td>
                                <td>${user.address || ''}</td>
                            `;
                            usersTableBody.appendChild(row);
                        });
                        feedback.classList.add('d-none');
                    }
                })
                .catch(error => {
                    console.error('Fetch Error:', error.message);
                    feedback.textContent = `An error occurred while searching: ${error.message}. Please try again.`;
                    feedback.classList.remove('alert-info', 'd-none');
                    feedback.classList.add('alert-danger');
                    usersTableBody.innerHTML = '<tr><td colspan="8" class="text-center">Error loading users.</td></tr>';
                });
        }

        // Live search with debounce
        searchInput.addEventListener('input', debounce(function () {
            const searchTerm = searchInput.value.trim();
            clearButton.disabled = searchTerm.length === 0;
            performSearch(searchTerm);
        }, 300));

        // Clear button
        clearButton.addEventListener('click', function () {
            searchInput.value = '';
            clearButton.disabled = true;
            performSearch('');
        });

        // Form submit (optional)
        searchForm.addEventListener('submit', function (event) {
            event.preventDefault();
            const searchTerm = searchInput.value.trim();
            clearButton.disabled = searchTerm.length === 0;
            performSearch(searchTerm);
        });

        // Initial clear button state
        clearButton.disabled = searchInput.value.trim().length === 0;
    }
});