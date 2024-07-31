const NotionPageToHtml = require('notion-page-to-html');
const fs = require('fs');

const options = {
  excludeCSS: true,
  excludeTitleFromHead: true,
};

async function getPage() {
  const { title, icon, cover, html } = await NotionPageToHtml.convert(process.argv[2],options);
  console.log(html); //how we pass stdout to shell
}

getPage();
