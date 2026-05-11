# Project Instructions

## Webasyst UI 2.0

For any task that creates or edits Webasyst backend UI for apps, plugins, widgets, settings pages, dialogs, tables, forms, or feature screens:

- First use `get_webasyst_ui_context`.
- Reuse real patterns from `wa-apps/ui/templates/actions/component/`.
- Use classes and layout primitives from `wa-content/css/wa/wa-2.0.css` before adding custom CSS.
- Use Webasyst JS helpers from `wa-content/js/jquery-wa/wa.js` and `wa-apps/ui/js/`.
- For new reusable snippets, prefer `create_webasyst_ui_component`.
- After UI changes, run `audit_webasyst_ui_surface` on changed backend templates and fix reported issues where applicable.
- Do not introduce Bootstrap, Tailwind, or unrelated design-system classes in Webasyst backend screens.
- Use `_w()` for app localization and `_wp()` for plugin localization.
