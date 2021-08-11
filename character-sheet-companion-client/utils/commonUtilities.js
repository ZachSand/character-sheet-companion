export async function getBase64ImageData(url) {
  return fetch(url)
    .then((response) => response.blob())
    .then(
      (blob) =>
        new Promise((resolve, reject) => {
          const reader = new FileReader();
          reader.onloadend = () => resolve(reader.result);
          reader.onerror = reject;
          reader.readAsDataURL(blob);
        })
    );
}

export function removeBase64Metadata(imageData) {
  return imageData.split(",")[1];
}

export function removeHtml(text) {
  return jQuery("<p>" + text + "</p>").text();
}
