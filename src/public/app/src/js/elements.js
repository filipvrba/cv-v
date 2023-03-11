import ElmProjects from "./elements/elm_projects.js";
import ElmProject from "./elements/elm_project.js";
import ElmArticles from "./elements/elm_articles.js";
import ElmProfile from "./elements/elm_profile.js";
import ElmGreet from "./elements/elm_greet.js";
import ElmArticlesAdmin from "./elements/elm_articles_admin.js";
import ElmProjectsAdmin from "./elements/elm_projects_admin.js";
window.customElements.define("elm-projects", ElmProjects);
window.customElements.define("elm-project", ElmProject);
window.customElements.define("elm-articles", ElmArticles);
window.customElements.define("elm-profile", ElmProfile);
window.customElements.define("elm-greet", ElmGreet);
window.customElements.define("elm-articles-admin", ElmArticlesAdmin);
window.customElements.define("elm-projects-admin", ElmProjectsAdmin)