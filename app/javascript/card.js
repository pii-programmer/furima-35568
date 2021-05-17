const pay = () => {
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    console.log("テスト！フォーム送信時にイベント発火")
  });
};

window.addEventListener("load", pay);