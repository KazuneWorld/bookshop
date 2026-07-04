// ヘッダースクロール制御
(function() {
    let lastScrollTop = 0;
    const scrollThreshold = 5; // スクロール感度
    const hideOffset = 100; // この位置を超えたら隠す

    function initScrollHeader() {
        const header = document.querySelector('header');
        window.addEventListener('scroll', function() {
            const currentScroll = window.pageYOffset || document.documentElement.scrollTop;

            // 上にスクロール
            if (currentScroll < lastScrollTop - scrollThreshold) {
                header.classList.remove('hidden');
                header.classList.add('visible');
            }
            // 下にスクロール（かつ少しスクロールされている）
            else if (currentScroll > lastScrollTop + scrollThreshold && currentScroll > hideOffset) {
                header.classList.remove('visible');
                header.classList.add('hidden');
            }

            // スクロール位置を更新
            lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
        });
    }

    // DOMが読み込まれたら実行
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initScrollHeader);
    } else {
        initScrollHeader();
    }
})();