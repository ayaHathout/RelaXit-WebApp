// statistics.js
console.log('statistics.js: Script loaded');
document.addEventListener('DOMContentLoaded', function () {
    console.log('statistics.js: DOMContentLoaded fired');
    console.log('statistics.js: chartLabels =', window.chartLabels);
    console.log('statistics.js: chartData =', window.chartData);

    const ctx = document.getElementById('usersChart');
    console.log('statistics.js: Canvas element =', ctx);
    if (!ctx) {
        console.error('statistics.js: Chart canvas not found!');
        return;
    }

    // Check if Chart.js is loaded
    if (typeof Chart === 'undefined') {
        console.error('statistics.js: Chart.js not loaded!');
        return;
    }

    // Check if chartLabels and chartData exist
    if (!window.chartLabels || !window.chartData || window.chartLabels.length === 0 || window.chartData.length === 0) {
        console.warn('statistics.js: No chart data available');
        ctx.style.display = 'none';
        const cardBody = ctx.parentElement;
        let noDataMessage = cardBody.querySelector('.text-center.text-muted');
        if (!noDataMessage) {
            noDataMessage = document.createElement('p');
            noDataMessage.className = 'text-center text-muted';
            noDataMessage.textContent = 'No user registration data available.';
            cardBody.appendChild(noDataMessage);
        }
        return;
    }

    try {
        console.log('statistics.js: Attempting to render chart...');
        const usersChart = new Chart(ctx.getContext('2d'), {
            type: 'bar',
            data: {
                labels: window.chartLabels,
                datasets: [{
                    label: 'New Users',
                    data: window.chartData,
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
        console.log('statistics.js: Chart rendered successfully:', usersChart);
    } catch (error) {
        console.error('statistics.js: Error rendering chart:', error.message);
        console.error('statistics.js: Error stack:', error.stack);
        ctx.style.display = 'none';
        const cardBody = ctx.parentElement;
        let errorMessage = cardBody.querySelector('.text-center.text-danger');
        if (!errorMessage) {
            errorMessage = document.createElement('p');
            errorMessage.className = 'text-center text-danger';
            errorMessage.textContent = 'Error rendering chart. Please try again later.';
            cardBody.appendChild(errorMessage);
        }
    }
});