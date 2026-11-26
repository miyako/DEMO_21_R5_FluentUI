![version](https://img.shields.io/badge/version-21%20R5%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)

# DEMO_21_R5_FluentUI

A 4D 21 R5 demo of the modernised form object library: **Fluent UI** on Windows and **Liquid Glass** on macOS, for both project forms and classic table forms. The UI is available in English and Japanese, and you can switch language while the app is running.

4D 21 R5 の新しいフォームオブジェクトライブラリ（Windows の **Fluent UI**、macOS の **Liquid Glass**）を、プロジェクトフォームと従来のテーブルフォームの両方で紹介するデモです。画面は英語と日本語に対応し、実行中に切り替えられます。

## Run / 起動方法

1. Install 4D 21 R5 or later ([download](https://us.4d.com/product-download), [activation](https://developer.4d.com/docs/GettingStarted/installation)).
   Fluent UI needs Windows 10/11, and Liquid Glass needs macOS 26 or later. Older systems show the classic look.
2. Clone or download this repository, then in 4D choose **File > Open Project** and select `Project/DEMO_21_R5_FluentUI.4DProject`.
3. The start screen opens. Use the dropdown at the top right to switch between **English** and **日本語**.

| Tile / タイル | Opens / 内容 |
|---|---|
| **Project Forms / プロジェクトフォーム** | ORDA list box, detail form with navigation, delete confirmation, and printing |
| **Table Forms / テーブルフォーム** | Classic output and input forms (`MODIFY SELECTION`) in the new style |
| **Generate Sample Data / サンプルデータを生成** | Replaces all records with sample data in the current language |

The shipped data is in English. Switch to 日本語 and click **サンプルデータを生成** to get Japanese records.
同梱データは英語です。日本語に切り替えて「サンプルデータを生成」をクリックすると、日本語のデータになります。

## What it demonstrates

- Project forms (`ProjectList`, `ProjectDetail`) driven by form classes (`ProjectListForm`, `ProjectDetailForm`) and ORDA entity selections
- Classic table forms (`[Project]`/`[Task]` OutputForm and DetailForm) that get the same modern look without code changes
- Style sheets per platform: `styleSheets.css` for shared classes (tiles, toolbar, data grid), with `styleSheets_mac.css` and `styleSheets_windows.css` for Liquid Glass / Fluent UI button and dropdown heights
- XLIFF localisation of forms, menus, tooltips, window titles and messages (`Resources/en.lproj`, `Resources/ja.lproj`)
- Stored values kept language-neutral: statuses are saved as English keys and displayed as localised labels
- Switching the display language at runtime and reopening the UI

## Key commands

| Command | Used for |
|---|---|
| `Localized string` | Texts in code (alerts, window titles, labels) |
| `SET DATABASE LOCALIZATION` | Switching the display language from the start screen |
| `Localized document path` | Loading `sampleData.json` for the current language |
| `Open form window` / `DIALOG(...; *)` | Non-blocking start screen and project list windows |
| `MODIFY SELECTION` / `FORM SET INPUT` | Classic table forms in their own process |
| `CALL WORKER` / `CALL FORM` | Opening the start screen in the application process and bringing existing windows to the front |

## How it works

`On Startup` calls `__start`. It opens the `StartScreen` form in the application process, or brings it to the front if it is already open. The tiles call `OpenProjectListForm`, `OpenListForm` and `GenerateData`.

Every text in forms is an `:xliff:` reference. Code uses `Localized string`, plus a small `LocalizedFormat` helper for strings with placeholders, such as `{1} of {2} projects` / `プロジェクト {2} 件中 {1} 件`.

Statuses (`To Do`, `Pending`, `In Progress`, `Completed`) are stored as keys. `StatusLabel` turns a key into the localised label. `StatusDropdown` builds the dropdown values. The `statusLabel` computed attribute on `ProjectEntity` and `TaskEntity` lets list boxes show and sort the label. Changing the language therefore never changes the data.

`SwitchLanguage` is the most interesting piece. It calls `SET DATABASE LOCALIZATION`, closes the start screen and reopens it with `CALL WORKER`, because forms that are already open keep the texts they were loaded with.

## Points of interest

- Built-in `Common*` XLIFF IDs (Cancel, Quit, Edit…) follow the language of the 4D application, not `SET DATABASE LOCALIZATION`. This project defines its own IDs (`Button_Cancel`, `Menu_File`…) so that the whole UI switches together.
- Japanese text is wider than English at the same font size. Check list box columns and buttons in both languages.
- Fluent UI is only applied on Windows. On macOS the same forms use Liquid Glass (macOS 26+) or the classic look.
- Liquid Glass and Fluent UI buttons and dropdowns need a taller height (27 px). The heights are set in the platform style sheets, not in each form.

## References

- [4D blog: Modernize your 4D interfaces with Fluent UI](https://blog.4d.com/modernize-your-4d-interfaces-with-fluent-ui/)
- [4D blog: Deploy Fluent UI effortlessly in your 4D applications](https://blog.4d.com/deploy-fluent-ui-effortlessly-in-your-4d-applications/)
- [4D blog: A Modernized Object Library with Fluent UI and Liquid Glass](https://blog.4d.com/a-modernized-object-library-with-fluent-ui/)
- [4D blog: Printing Modern Interfaces with Clean, Consistent Output](https://blog.4d.com/printing-modern-interfaces-with-clean-consistent-output/)
- [4D documentation: Localized string](https://developer.4d.com/docs/commands/localized-string)
- [4D documentation: SET DATABASE LOCALIZATION](https://developer.4d.com/docs/commands/set-database-localization)
