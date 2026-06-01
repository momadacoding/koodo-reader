import { isBuiltinAutoUpdateEnabled } from "./updateSupport";

declare const describe: any;
declare const it: any;
declare const expect: any;

describe("updateSupport", () => {
  it("disables built-in auto update for the forked desktop app", () => {
    expect(isBuiltinAutoUpdateEnabled()).toBe(false);
  });
});
