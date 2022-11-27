/* script to insert content */

const createItemRow = item => {

    const title = item.title ? `
            <h2 class="row-title"> ${item.title} </h2>
        ` : '';

    const text = item.text ? `
            <div class="row-text">
                <pre>${item.text}</pre>
            </div>
        ` : '';

    const subItems = item.items
        .map(subItem => createSubItem(subItem))
        .join('');

    return `
            <div class="row">
                ${title}
                ${text}
              <div class="row-items">
                ${subItems}
              </div>
            </div>
        `;
}

const createSubItem = ({ label, href, image }) => {
    const shortLabel = (label.length > 28) ? `${label.substring(0,25)}...` : label;

    return `
        <a target="_blank" rel="noopener noreferrer" href="${href}" class="item">
           <img src="${image}" class="item-image">
           <span class="item-caption" style="text-align:center;font-weight:bold"> ${shortLabel} </span>
        </a>
        `;
}

/* end of script */

const container = document.querySelector('#content');
container.innerHTML = contentItems
    .map(item => createItemRow(item))
    .join('');

/* --- */