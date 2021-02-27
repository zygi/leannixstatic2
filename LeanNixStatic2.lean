import LeanNixStatic1.Inline
import LeanNixStatic1.Extern

-- When reducing, we get the Lean implementation
#reduce 0 == ifNative1Else0 0

-- When eval-ing, we get the native implementation. That's the plugin at work.
#eval 1 == ifNative1Else0 0

-- And of course we can use these native implementations when compiling
-- natively.
def main(argv: List String): IO UInt32 := do
 IO.println s!"{ifNative1Else0 0} should be 1"
 IO.println s!"{addMagicConstant 0} should be 12345"
 return 0