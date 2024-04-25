document.addEventListener('DOMContentLoaded', () => {
    var form = document.querySelector('.tweet-form');
    var errorMessages = document.getElementById('error_messages');
    if (form) {
      form.addEventListener('submit', async (event) => {
        event.preventDefault();
        var content = form.querySelector('.tweet-content').value;
        try {
          var response = await fetch(form.action, {
            method: form.method,
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': form.querySelector('[name="csrf-token"]').content
            },
            body: JSON.stringify({ tweet: { content } })
          });
          var data = await response.json();
          if (!response.ok) {
            throw new Error(data.errors.join(', '));
          }
          window.location.href = '/tweets';
        } catch (error) {
          console.error('Error:', error);
          errorMessages.innerHTML = `<div class="alert alert-danger">${error.message}</div>`;
        }
      });
    }
  });
  