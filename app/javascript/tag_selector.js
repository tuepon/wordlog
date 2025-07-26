document.addEventListener("DOMContentLoaded", () => {
  const tagInput = document.getElementById("tag-input");
  const tagButtons = document.querySelectorAll(".tag-button");

  if (!tagInput) return;

  tagButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const tag = button.dataset.tag;
      let currentTags = tagInput.value
        .split(",")
        .map((t) => t.trim())
        .filter((t) => t.length > 0);

      if (currentTags.includes(tag)) {
        // すでにある場合は削除
        currentTags = currentTags.filter((t) => t !== tag);
        button.classList.remove("bg-blue-600", "text-white");
        button.classList.add("bg-gray-100");
      } else {
        // 追加
        currentTags.push(tag);
        button.classList.add("bg-blue-600", "text-white");
        button.classList.remove("bg-gray-100");
      }
      tagInput.value = currentTags.join(", ");
    });
  });
});
