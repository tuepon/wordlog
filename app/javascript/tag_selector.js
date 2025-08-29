console.log("✅ tag_selector.js loaded");

document.addEventListener("turbo:load", () => {
  console.log("tag_selector loaded!"); // デバッグ
  const input = document.querySelector("#tag-input");
  const buttons = document.querySelectorAll(".tag-button");

  if (!input || buttons.length === 0) return;

  buttons.forEach((btn) => {
    btn.addEventListener("click", () => {
      console.log("clicked:", btn.dataset.tag); // デバッグ
      const tag = btn.dataset.tag;
      let tags = input.value
        .split(",")
        .map((t) => t.trim())
        .filter((t) => t !== "");

      // クリック時に選択トグル
      if (tags.includes(tag)) {
        tags = tags.filter((t) => t !== tag);
        btn.classList.remove("bg-blue-500", "text-white");
        btn.classList.add("bg-gray-100");
      } else {
        tags.push(tag);
        btn.classList.add("bg-blue-500", "text-white");
        btn.classList.remove("bg-gray-100");
      }

      input.value = tags.join(", ");
    });
  });

  // 既存タグがフォームにあればボタンを青くする
  const currentTags = input.value.split(",").map((t) => t.trim());
  buttons.forEach((btn) => {
    if (currentTags.includes(btn.dataset.tag)) {
      btn.classList.add("bg-blue-500", "text-white");
      btn.classList.remove("bg-gray-100");
    }
  });
});
