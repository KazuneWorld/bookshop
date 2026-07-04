
// ページ読み込み時にポップアップを表示
window.addEventListener('DOMContentLoaded', function() {
  // 初期状態でポップアップを表示
  document.getElementById('adOverlay').style.display = 'block';
  document.getElementById('adPopup').style.display = 'block';
  
  // イベントリスナーを設定
  setupEventListeners();
});

function setupEventListeners() {
  // 「短い広告を見る」ボタンをクリック
  const playAdBtn = document.getElementById('playAdBtn');
  if (playAdBtn) {
    playAdBtn.addEventListener('click', function(e) {
      e.stopPropagation(); // イベントの伝播を止める
      startAdPlayback();
    });
  }
  
  // アクションボックス全体をクリック可能に
  const actionBox = document.querySelector('.ad-action-box');
  if (actionBox) {
    actionBox.addEventListener('click', function() {
      startAdPlayback();
    });
  }
  
  // 閉じるボタンをクリック
  const closeAdBtn = document.getElementById('closeAdBtn');
  if (closeAdBtn) {
    closeAdBtn.addEventListener('click', function() {
      closeAllModals();
    });
  }
}

function startAdPlayback() {
  // 最初のポップアップを非表示
  document.getElementById('adPopup').style.display = 'none';
  
  // 広告再生モーダルを表示
  document.getElementById('adVideoModal').style.display = 'block';
  
  // カウントダウン開始
  let timeLeft = 15;
  const timerElement = document.getElementById('adTimer');
  
  const countdown = setInterval(function() {
    timeLeft--;
    if (timeLeft > 0) {
      timerElement.textContent = timeLeft + ' 秒後に報酬を獲得できます';
    } else {
      clearInterval(countdown);
      
      // 広告再生モーダルを非表示
      document.getElementById('adVideoModal').style.display = 'none';
      
      // 広告完了モーダルを表示（閉じるボタンあり）
      document.getElementById('adCompleteModal').style.display = 'block';
    }
  }, 1000);
}

function closeAllModals() {
  // すべてのモーダルを非表示
  document.getElementById('adOverlay').style.display = 'none';
  document.getElementById('adPopup').style.display = 'none';
  document.getElementById('adVideoModal').style.display = 'none';
  document.getElementById('adCompleteModal').style.display = 'none';
}