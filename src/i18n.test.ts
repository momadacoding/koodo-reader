import { mergeLocaleWithAcornyOverlay } from "./i18n";

declare const describe: any;
declare const it: any;
declare const expect: any;

describe("i18n", () => {
  it("merges Acorny locale overlay without mutating the base locale", () => {
    const baseLocale = {
      "Existing key": "Existing translation",
      "Acorny Personal Access Token": "Base token label",
    };
    const acornyOverlay = {
      "Acorny Personal Access Token": "Overlay token label",
      "Enter your Acorny personal access token": "Overlay token prompt",
    };

    expect(
      mergeLocaleWithAcornyOverlay(baseLocale, acornyOverlay)
    ).toEqual({
      "Existing key": "Existing translation",
      "Acorny Personal Access Token": "Overlay token label",
      "Enter your Acorny personal access token": "Overlay token prompt",
    });
    expect(baseLocale).toEqual({
      "Existing key": "Existing translation",
      "Acorny Personal Access Token": "Base token label",
    });
  });
});
