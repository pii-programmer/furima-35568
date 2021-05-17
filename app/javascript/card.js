const pay = () => {
  Payjp.setPublicKey("pk_test_a2f8609fd10357e8d96e54f1");
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_address[number]"),
      exp_month: formData.get("order_address[exp_month]"),
      exp_year: `20${formData.get("order_address[exp_year]")}`,
      cvc: formData.get("order_address[cvc]"),
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200){
        const token = response.id;
      }
    });
  });
};

window.addEventListener("load", pay);