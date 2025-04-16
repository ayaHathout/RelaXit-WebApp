console.log('statistics.js: Script loaded');

let usersChartInstance = null;
let pollInterval = null;

document.addEventListener('DOMContentLoaded', function () {
    console.log('statistics.js: DOMContentLoaded fired');
    console.log('statistics.js: Initial chartLabels =', window.chartLabels);
    console.log('statistics.js: Initial chartData =', window.chartData);

    const ctx = document.getElementById('usersChart');
    console.log('statistics.js: Canvas element =', ctx);
    if (!ctx) {
        console.error('statistics.js: Chart canvas not found!');
        return;
    }

    const containerFluid = document.querySelector('.container-fluid');
    if (containerFluid) {
        console.log('statistics.js: Setting container-fluid to visible');
        containerFluid.style.display = 'block';
        containerFluid.style.visibility = 'visible';
    }

    // Check if Chart.js is loaded
    if (typeof Chart === 'undefined') {
        console.error('statistics.js: Chart.js not loaded!');
        return;
    }

    // Initialize chart
    function initializeChart(labels, data) {
        if (usersChartInstance) {
            usersChartInstance.destroy();
            console.log('statistics.js: Previous chart instance destroyed');
        }

        if (!labels || !data || labels.length === 0 || data.length === 0) {
            console.warn('statistics.js: No chart data available');
            ctx.style.display = 'none';
            document.getElementById('no-chart-data').style.display = 'block';
            return;
        }

        try {
            console.log('statistics.js: Rendering chart with labels =', labels, 'data =', data);
            ctx.style.display = 'block';
            ctx.style.visibility = 'visible';
            document.getElementById('no-chart-data').style.display = 'none';
            usersChartInstance = new Chart(ctx.getContext('2d'), {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'New Users',
                        data: data,
                        backgroundColor: 'rgba(43, 108, 176, 0.6)',
                        borderColor: '#2b6cb0',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: { display: true, text: 'Number of Users' }
                        },
                        x: {
                            title: { display: true, text: 'Month' }
                        }
                    },
                    plugins: {
                        legend: { display: true, position: 'top' }
                    }
                }
            });
            console.log('statistics.js: Chart rendered successfully:', usersChartInstance);
        } catch (error) {
            console.error('statistics.js: Error rendering chart:', error.message);
            console.error('statistics.js: Error stack:', error.stack);
            ctx.style.display = 'none';
            document.getElementById('no-chart-data').style.display = 'block';
        }
    }

    // Update UI with statistics
    function updateStats(stats) {
        console.log('statistics.js: Updating UI with stats:', stats);

        // Update cards
        const totalUsersEl = document.getElementById('total-users');
        const totalUsersZeroEl = document.getElementById('total-users-zero');
        totalUsersEl.textContent = stats.totalUsers || '0';
        totalUsersEl.style.visibility = 'visible';
        totalUsersZeroEl.style.display = stats.totalUsers > 0 ? 'none' : 'block';

        const totalProductsEl = document.getElementById('total-products');
        const totalProductsZeroEl = document.getElementById('total-products-zero');
        totalProductsEl.textContent = stats.totalProducts || '0';
        totalProductsEl.style.visibility = 'visible';
        totalProductsZeroEl.style.display = stats.totalProducts > 0 ? 'none' : 'block';

        const avgCreditLimitEl = document.getElementById('avg-credit-limit');
        const avgCreditLimitZeroEl = document.getElementById('avg-credit-limit-zero');
        avgCreditLimitEl.textContent = stats.avgCreditLimit > 0 ? '$' + stats.avgCreditLimit.toFixed(2) : '$0.00';
        avgCreditLimitEl.style.visibility = 'visible';
        avgCreditLimitZeroEl.style.display = stats.avgCreditLimit > 0 ? 'none' : 'block';

        const totalStockEl = document.getElementById('total-stock');
        const totalStockZeroEl = document.getElementById('total-stock-zero');
        totalStockEl.textContent = stats.totalStock || '0';
        totalStockEl.style.visibility = 'visible';
        totalStockZeroEl.style.display = stats.totalStock > 0 ? 'none' : 'block';

        // Update chart
        initializeChart(stats.chartLabels || [], stats.chartData || []);
    }

    // Fetch statistics via AJAX
    function fetchStatistics() {
        console.log('statistics.js: Fetching statistics...');
        const loadingEl = document.getElementById('stats-loading');
        loadingEl.classList.remove('d-none');

        fetch('/relaxit/admin/statistics/data', {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            },
            credentials: 'same-origin'
        })
            .then(response => {
                if (response.status === 401 || response.status === 403) {
                    console.warn('statistics.js: Session expired or unauthorized, redirecting to login');
                    window.location.href = '/relaxit/login';
                    return Promise.reject('Unauthorized');
                }
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log('statistics.js: Received stats:', data);
                updateStats(data);
                loadingEl.classList.add('d-none');
            })
            .catch(error => {
                if (error === 'Unauthorized') return;
                console.error('statistics.js: Error fetching statistics:', error.message);
                loadingEl.classList.add('d-none');
                const noDataMessage = document.getElementById('no-chart-data');
                noDataMessage.textContent = 'Error loading statistics. Please try again later.';
                noDataMessage.style.color = '#dc3545';
                noDataMessage.style.display = 'block';
            });
    }

    // Initialize chart with initial data
    initializeChart(window.chartLabels, window.chartData);

    // Start polling every 30 seconds
    pollInterval = setInterval(fetchStatistics, 3000);
    console.log('statistics.js: Polling started with interval ID:', pollInterval);

    // Clean up on page unload
    window.addEventListener('beforeunload', function () {
        if (pollInterval) {
            clearInterval(pollInterval);
            console.log('statistics.js: Polling stopped');
        }
        if (usersChartInstance) {
            usersChartInstance.destroy();
            console.log('statistics.js: Chart instance destroyed on unload');
        }
    });
});