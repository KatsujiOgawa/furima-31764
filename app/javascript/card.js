const pay = () => {
  Payjp.setPublicKey("pk_test_b3b634db166181a2111e8ff6")
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("buy_shipment[number]"),
      cvc: formData.get("buy_shipment[cvc]"),
      exp_month: formData.get("buy_shipment[exp_month]"),
      exp_year: `20${formData.get("buy_shipment[exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const rendeDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        rendeDom.insertAdjacentHTML("beforeend", tokenObj);
        debugger;
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);