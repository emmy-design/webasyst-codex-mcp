# Стандарты разработки Webasyst

## ОБЯЗАТЕЛЬНЫЕ ТРЕБОВАНИЯ

При разработке для Webasyst **ВСЕГДА** следуйте этим правилам:

### 1. Кодировка файлов

**ОБЯЗАТЕЛЬНО:** Все файлы должны быть в кодировке UTF-8 БЕЗ BOM.

**ЗАПРЕЩЕНО:** UTF-8 with BOM, другие кодировки.

Проверка в редакторе: статусбар или свойства файла должны показывать `UTF-8`, не `UTF-8 with BOM`.

### 2. UI и стилизация

**ОБЯЗАТЕЛЬНО используйте:**
- Компоненты из `wa-apps/ui/templates/actions/component/`
- Классы из `wa-content/css/wa/wa-2.0.css`
- CSS-переменные для всех цветов и размеров
- Подключайте UI через `{include file="ui_wrapper.html"}` (MCP создаёт заготовку)

**ЗАПРЕЩЕНО:**
- Хардкодить цвета (используйте `var(--accent-color)` и т.д.)
- Создавать кастомные стили для стандартных элементов
- Игнорировать готовые компоненты

**Документация:**
- [UI_COMPONENTS_REFERENCE.md](UI_COMPONENTS_REFERENCE.md) - Полный справочник компонентов

### 3. Локализация

**ОБЯЗАТЕЛЬНО:**
- Создавать отдельные action/controller для JS локализации
- Использовать `_w()` в PHP для приложений, `_wp()` для плагинов, и `$_()` в JavaScript
- Следовать стандартной структуре файлов
- Пользоваться MCP инструментами `generate_po_template` и `compile_mo` для .po/.mo

**ЗАПРЕЩЕНО:**
- Встраивать локализацию в основные шаблоны
- Хардкодить строки на любом языке
- Дублировать ключи локализации

**Документация:**
- [LOCALIZATION_GUIDE.md](LOCALIZATION_GUIDE.md) - Полное руководство

### 4. Структура приложений

**ОБЯЗАТЕЛЬНАЯ структура:**
```
wa-apps/your-app/
├── lib/
│   ├── actions/          # Контроллеры
│   │   └── backend/
│   │       ├── appBackend.action.php
│   │       ├── appBackendLoc.action.php      # Локализация
│   │       └── appBackendLoc.controller.php
│   ├── config/           # Конфигурация
│   ├── classes/          # Классы
│   └── models/           # Модели
├── templates/            # Шаблоны
│   └── actions/
│       └── backend/
├── css/                  # Стили (минимум кастомных!)
├── js/                   # JavaScript
├── locale/               # Переводы
└── img/                  # Изображения
```

## Быстрый старт UI

### Подключение стилей:
```html
<link rel="stylesheet" href="{$wa_url}wa-content/css/wa/wa-2.0.css">
```

### Базовая кнопка:
```html
<button type="button" class="button blue">Сохранить</button>
```

### Поле ввода:
```html
<div class="field">
    <div class="name">Название</div>
    <div class="value">
        <input type="text" class="bold">
    </div>
</div>
```

### Таблица:
```html
<table class="zebra">
    <thead>
        <tr><th>ID</th><th>Название</th></tr>
    </thead>
    <tbody>
        <tr><td>1</td><td>Элемент</td></tr>
    </tbody>
</table>
```

### Алерт:
```html
<div class="alert success">
    <i class="fas fa-check-circle"></i> Успешно сохранено
</div>
```

## Быстрый старт локализации

### Backend (PHP):
```php
echo _w('Save');  // Простая строка
echo _w('%d item', '%d items', $count);  // Плюрализация
```

### Frontend (JavaScript):
```javascript
alert($_('Are you sure?'));  // Через глобальную функцию
```

### Создание локализации для JS:
```php
// lib/actions/backend/appBackendLoc.action.php
class appBackendLocAction extends waViewAction {
    public function execute() {
        $strings = array();
        foreach(array('Save', 'Cancel', 'Delete') as $s) {
            $strings[$s] = _w($s);
        }
        $this->view->assign('strings', $strings ?: new stdClass());
        $this->getResponse()->addHeader('Content-Type', 'text/javascript; charset=utf-8');
    }
}
```

## Чек-лист разработчика

Перед коммитом проверьте:

### Кодировка:
- [ ] Все файлы в UTF-8 без BOM

### UI:
- [ ] Используются компоненты из `wa-apps/ui/`
- [ ] Применяются классы из `wa-2.0.css`
- [ ] Цвета через CSS-переменные
- [ ] Нет кастомных стилей для стандартных элементов

### Локализация:
- [ ] Создан `BackendLoc.action.php`
- [ ] Все строки локализованы
- [ ] JS использует `$_()`
- [ ] Нет хардкода текста

### Код:
- [ ] Следует структуре Webasyst
- [ ] Используются стандартные классы фреймворка
- [ ] Есть комментарии к сложной логике

## Полезные MCP tools

- `get_webasyst_ui_context` - получить обязательный контекст Webasyst UI 2.0 перед работой с backend UI.
- `list_webasyst_ui_components` - посмотреть реальные компоненты из `wa-apps/ui/templates/actions/component`.
- `get_webasyst_ui_component` - прочитать исходник конкретного UI-компонента.
- `create_webasyst_ui_component` - создать готовый app/plugin snippet с `_w()` или `_wp()`.
- `audit_webasyst_ui_surface` - проверить шаблон после правок.
- `create_app_structure`, `create_plugin_structure`, `create_widget`, `create_action`, `create_model` - scaffold-инструменты.
- `generate_po_template`, `compile_mo`, `check_project_compliance`, `prepare_release_bundle` - локализация, проверка и подготовка релиза.

## Вся документация

1. **[README.md](README.md)** - Основная документация
2. **[QUICKSTART.md](QUICKSTART.md)** - Быстрый старт
3. **[UI_COMPONENTS_REFERENCE.md](UI_COMPONENTS_REFERENCE.md)** - Справочник компонентов
4. **[LOCALIZATION_GUIDE.md](LOCALIZATION_GUIDE.md)** - Локализация
5. **[EXAMPLES.md](EXAMPLES.md)** - Примеры команд
6. **[AGENTS.md](AGENTS.md)** - Правила для Codex-агентов

## Золотые правила

1. **Не изобретайте велосипед** - используйте готовые компоненты
2. **Консистентность важнее креативности** - следуйте стандартам
3. **Локализация с первого дня** - не оставляйте на потом
4. **CSS-переменные для всего** - никакого хардкода цветов
5. **Документируйте нестандартные решения** - помогите будущим разработчикам
6. **UTF-8 без BOM** - никаких исключений

---

**ПОМНИТЕ:** Следование стандартам = меньше багов + быстрее разработка + легче поддержка!
