export default class HeaderAdmin {
  static click_articles_tab_pane() {
    location.hash = HeaderAdmin.ARTICLES_HASH
  };

  static click_projects_tab_pane() {
    location.hash = HeaderAdmin.PROJECTS_HASH
  };

  static autoselect_tab_pane() {
    switch (location.hash) {
    case HeaderAdmin.ARTICLES_HASH:
      let btn_articles_tab = document.getElementById(HeaderAdmin.ARTICLES_TAB);
      btn_articles_tab.click();
      break;

    case HeaderAdmin.PROJECTS_HASH:
      let btn_projects_tab = document.getElementById(HeaderAdmin.PROJECTS_TAB);
      btn_projects_tab.click()
    }
  }
};

HeaderAdmin.ARTICLES_TAB = "articles-tab";
HeaderAdmin.PROJECTS_TAB = "projects-tab";
HeaderAdmin.ARTICLES_HASH = `#select-${HeaderAdmin.ARTICLES_TAB}`;
HeaderAdmin.PROJECTS_HASH = `#select-${HeaderAdmin.PROJECTS_TAB}`;
window.click_articles_tab_pane = HeaderAdmin.click_articles_tab_pane;
window.click_projects_tab_pane = HeaderAdmin.click_projects_tab_pane;
HeaderAdmin.autoselect_tab_pane()