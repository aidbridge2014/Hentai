// script.js

document.addEventListener('DOMContentLoaded', () => {
  const userButton = document.querySelector('header .group > button');
  const userMenu = document.querySelector('header .group > div');

  if (userButton && userMenu) {
    userButton.addEventListener('click', (e) => {
      e.stopPropagation(); // чтобы клик по кнопке не закрывал меню сразу
      userMenu.classList.toggle('hidden');
    });

    // Закрываем меню, если клик вне меню и кнопки
    document.addEventListener('click', () => {
      if (!userMenu.classList.contains('hidden')) {
        userMenu.classList.add('hidden');
      }
    });

    // Чтобы клик внутри меню не закрывал его
    userMenu.addEventListener('click', (e) => {
      e.stopPropagation();
    });
  }
});
