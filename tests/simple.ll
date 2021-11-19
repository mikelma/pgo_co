; ModuleID = 'tests/simple/main.c'
source_filename = "tests/simple/main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"num: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @show(i32 %0) #0 !prof !31 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 %3)
  ret void
}

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !prof !32 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 0, i32* %2, align 4
  br label %3

3:                                                ; preds = %13, %0
  %4 = load i32, i32* %2, align 4
  %5 = icmp slt i32 %4, 10
  br i1 %5, label %6, label %16, !prof !33

6:                                                ; preds = %3
  %7 = load i32, i32* %2, align 4
  %8 = srem i32 %7, 2
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %12, !prof !34

10:                                               ; preds = %6
  %11 = load i32, i32* %2, align 4
  call void @show(i32 %11)
  br label %12

12:                                               ; preds = %10, %6
  br label %13

13:                                               ; preds = %12
  %14 = load i32, i32* %2, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %2, align 4
  br label %3, !llvm.loop !35

16:                                               ; preds = %3
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !29}
!llvm.ident = !{!30}

!0 = !{i32 1, !"ProfileSummary", !1}
!1 = !{!2, !3, !4, !5, !6, !7, !8, !9, !10, !11}
!2 = !{!"ProfileFormat", !"InstrProf"}
!3 = !{!"TotalCount", i64 21}
!4 = !{!"MaxCount", i64 10}
!5 = !{!"MaxInternalCount", i64 10}
!6 = !{!"MaxFunctionCount", i64 5}
!7 = !{!"NumCounts", i64 4}
!8 = !{!"NumFunctions", i64 2}
!9 = !{!"IsPartialProfile", i64 0}
!10 = !{!"PartialProfileRatio", double 0.000000e+00}
!11 = !{!"DetailedSummary", !12}
!12 = !{!13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28}
!13 = !{i32 10000, i64 0, i32 0}
!14 = !{i32 100000, i64 10, i32 1}
!15 = !{i32 200000, i64 10, i32 1}
!16 = !{i32 300000, i64 10, i32 1}
!17 = !{i32 400000, i64 10, i32 1}
!18 = !{i32 500000, i64 10, i32 1}
!19 = !{i32 600000, i64 5, i32 3}
!20 = !{i32 700000, i64 5, i32 3}
!21 = !{i32 800000, i64 5, i32 3}
!22 = !{i32 900000, i64 5, i32 3}
!23 = !{i32 950000, i64 5, i32 3}
!24 = !{i32 990000, i64 5, i32 3}
!25 = !{i32 999000, i64 5, i32 3}
!26 = !{i32 999900, i64 5, i32 3}
!27 = !{i32 999990, i64 5, i32 3}
!28 = !{i32 999999, i64 5, i32 3}
!29 = !{i32 1, !"wchar_size", i32 4}
!30 = !{!"clang version 12.0.1"}
!31 = !{!"function_entry_count", i64 5}
!32 = !{!"function_entry_count", i64 1}
!33 = !{!"branch_weights", i32 11, i32 2}
!34 = !{!"branch_weights", i32 6, i32 6}
!35 = distinct !{!35, !36}
!36 = !{!"llvm.loop.mustprogress"}
