// script.js

document.addEventListener('DOMContentLoaded', () => {
  // Переключение темы
  const themeToggle = document.getElementById('theme-toggle');
  const html = document.documentElement;

  if (localStorage.getItem('theme') === 'dark' || (!localStorage.getItem('theme') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      html.classList.add('dark');
  } else {
      html.classList.remove('dark');
  }

  themeToggle.addEventListener('click', () => {
      html.classList.toggle('dark');
      localStorage.setItem('theme', html.classList.contains('dark') ? 'dark' : 'light');
  });

  // Мобильное меню
  const mobileMenuButton = document.getElementById('mobile-menu-button');
  const mobileMenu = document.getElementById('mobile-menu');

  mobileMenuButton.addEventListener('click', () => {
      mobileMenu.classList.toggle('hidden');
  });

  // Кнопка "Наверх"
  const backToTopButton = document.getElementById('back-to-top');

  window.addEventListener('scroll', () => {
      if (window.pageYOffset > 300) {
          backToTopButton.classList.remove('opacity-0', 'invisible');
          backToTopButton.classList.add('opacity-100', 'visible');
      } else {
          backToTopButton.classList.remove('opacity-100', 'visible');
          backToTopButton.classList.add('opacity-0', 'invisible');
      }
  });

  backToTopButton.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  // Симуляция загрузки
  const loadingOverlay = document.getElementById('loading-overlay');

  setTimeout(() => {
      loadingOverlay.classList.add('hidden');
  }, 1500);

  // Клик по карточкам хентая
  document.querySelectorAll('.hentai-card').forEach(card => {
      card.addEventListener('click', () => {
          loadingOverlay.classList.remove('hidden');

          setTimeout(() => {
              loadingOverlay.classList.add('hidden');
              alert('Открывается хентай... В реальном приложении здесь была бы страница с просмотром');
          }, 1000);
      });
  });

  // Меню пользователя (иконка логина)
  const userButton = document.querySelector('header .group > button');
  const userMenu = document.querySelector('header .group > div');

  if (userButton && userMenu) {
      userButton.addEventListener('click', (e) => {
          e.stopPropagation();
          userMenu.classList.toggle('hidden');
      });

      // Закрытие меню при клике вне
      document.addEventListener('click', () => {
          if (!userMenu.classList.contains('hidden')) {
              userMenu.classList.add('hidden');
          }
      });

      // Предотвращаем закрытие меню при клике внутри
      userMenu.addEventListener('click', (e) => {
          e.stopPropagation();
      });
  }
});
