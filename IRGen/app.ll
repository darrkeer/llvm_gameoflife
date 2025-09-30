; ModuleID = 'app.c'
source_filename = "app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@data = internal unnamed_addr global [2 x [480000 x i8]] zeroinitializer, align 16
@t = internal unnamed_addr global i32 0, align 4

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(read, argmem: none, inaccessiblemem: none) uwtable
define dso_local signext i8 @is_alive(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = load i32, ptr @t, align 4, !tbaa !5
  %4 = zext nneg i32 %3 to i64
  %5 = mul nsw i32 %1, 600
  %6 = add nsw i32 %5, %0
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %4, i64 %7
  %9 = load i8, ptr %8, align 1, !tbaa !9
  ret i8 %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @set_alive(i32 noundef %0, i32 noundef %1, i8 noundef signext %2) local_unnamed_addr #1 {
  %4 = load i32, ptr @t, align 4, !tbaa !5
  %5 = icmp eq i32 %4, 0
  %6 = zext i1 %5 to i64
  %7 = mul nsw i32 %1, 600
  %8 = add nsw i32 %7, %0
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %6, i64 %9
  store i8 %2, ptr %10, align 1, !tbaa !9
  ret void
}

; Function Attrs: nounwind optsize uwtable
define dso_local void @generate_field() local_unnamed_addr #2 {
  br label %1

1:                                                ; preds = %0, %4
  %2 = phi i64 [ 0, %0 ], [ %5, %4 ]
  br label %7

3:                                                ; preds = %4
  ret void

4:                                                ; preds = %7
  %5 = add nuw nsw i64 %2, 1
  %6 = icmp eq i64 %5, 800
  br i1 %6, label %3, label %1, !llvm.loop !10

7:                                                ; preds = %1, %7
  %8 = phi i64 [ 0, %1 ], [ %19, %7 ]
  %9 = tail call i32 (...) @sim_get_rand() #7
  %10 = srem i32 %9, 5
  %11 = icmp sgt i32 %10, 1
  %12 = load i32, ptr @t, align 4, !tbaa !5
  %13 = icmp eq i32 %12, 0
  %14 = zext i1 %13 to i64
  %15 = mul nuw nsw i64 %8, 600
  %16 = add nuw nsw i64 %15, %2
  %17 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %14, i64 %16
  %18 = zext i1 %11 to i8
  store i8 %18, ptr %17, align 1, !tbaa !9
  %19 = add nuw nsw i64 %8, 1
  %20 = icmp eq i64 %19, 600
  br i1 %20, label %4, label %7, !llvm.loop !12
}

; Function Attrs: optsize
declare i32 @sim_get_rand(...) local_unnamed_addr #3

; Function Attrs: nofree norecurse nosync nounwind optsize memory(read, argmem: none, inaccessiblemem: none) uwtable
define dso_local i32 @calc_siblings(i32 noundef %0, i32 noundef %1) local_unnamed_addr #4 {
  %3 = load i32, ptr @t, align 4
  %4 = zext nneg i32 %3 to i64
  br label %5

5:                                                ; preds = %2, %11
  %6 = phi i32 [ 0, %2 ], [ %35, %11 ]
  %7 = phi i32 [ -1, %2 ], [ %12, %11 ]
  %8 = add nsw i32 %7, %0
  %9 = icmp ugt i32 %8, 799
  br label %14

10:                                               ; preds = %11
  ret i32 %35

11:                                               ; preds = %34
  %12 = add nsw i32 %7, 1
  %13 = icmp eq i32 %12, 2
  br i1 %13, label %10, label %5, !llvm.loop !13

14:                                               ; preds = %5, %34
  %15 = phi i32 [ %6, %5 ], [ %35, %34 ]
  %16 = phi i32 [ -1, %5 ], [ %36, %34 ]
  %17 = add nsw i32 %16, %1
  %18 = icmp slt i32 %17, 0
  %19 = select i1 %9, i1 true, i1 %18
  %20 = icmp sgt i32 %17, 599
  %21 = select i1 %19, i1 true, i1 %20
  %22 = or i32 %16, %7
  %23 = icmp eq i32 %22, 0
  %24 = or i1 %23, %21
  br i1 %24, label %34, label %25

25:                                               ; preds = %14
  %26 = mul nuw nsw i32 %17, 600
  %27 = add nuw nsw i32 %26, %8
  %28 = zext nneg i32 %27 to i64
  %29 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %4, i64 %28
  %30 = load i8, ptr %29, align 1, !tbaa !9
  %31 = icmp ne i8 %30, 0
  %32 = zext i1 %31 to i32
  %33 = add nsw i32 %15, %32
  br label %34

34:                                               ; preds = %14, %25
  %35 = phi i32 [ %33, %25 ], [ %15, %14 ]
  %36 = add nsw i32 %16, 1
  %37 = icmp eq i32 %36, 2
  br i1 %37, label %11, label %14, !llvm.loop !14
}

; Function Attrs: nofree norecurse nosync nounwind optsize memory(readwrite, argmem: read, inaccessiblemem: none) uwtable
define dso_local void @update_field() local_unnamed_addr #5 {
  %1 = load i32, ptr @t, align 4
  %2 = zext nneg i32 %1 to i64
  %3 = icmp eq i32 %1, 0
  %4 = zext i1 %3 to i64
  br label %5

5:                                                ; preds = %0, %9
  %6 = phi i64 [ 0, %0 ], [ %10, %9 ]
  %7 = trunc i64 %6 to i32
  br label %12

8:                                                ; preds = %9
  ret void

9:                                                ; preds = %32
  %10 = add nuw nsw i64 %6, 1
  %11 = icmp eq i64 %10, 800
  br i1 %11, label %8, label %5, !llvm.loop !15

12:                                               ; preds = %5, %32
  %13 = phi i64 [ 0, %5 ], [ %33, %32 ]
  %14 = trunc i64 %13 to i32
  %15 = tail call i32 @calc_siblings(i32 noundef %7, i32 noundef %14) #8
  %16 = mul nuw nsw i64 %13, 600
  %17 = add nuw nsw i64 %16, %6
  %18 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %2, i64 %17
  %19 = load i8, ptr %18, align 1, !tbaa !9
  %20 = icmp eq i8 %19, 1
  br i1 %20, label %21, label %27

21:                                               ; preds = %12
  %22 = and i32 %15, -2
  %23 = icmp eq i32 %22, 2
  %24 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %4, i64 %17
  br i1 %23, label %25, label %26

25:                                               ; preds = %21
  store i8 1, ptr %24, align 1, !tbaa !9
  br label %32

26:                                               ; preds = %21
  store i8 0, ptr %24, align 1, !tbaa !9
  br label %32

27:                                               ; preds = %12
  %28 = icmp eq i32 %15, 3
  %29 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %4, i64 %17
  br i1 %28, label %30, label %31

30:                                               ; preds = %27
  store i8 1, ptr %29, align 1, !tbaa !9
  br label %32

31:                                               ; preds = %27
  store i8 0, ptr %29, align 1, !tbaa !9
  br label %32

32:                                               ; preds = %30, %31, %25, %26
  %33 = add nuw nsw i64 %13, 1
  %34 = icmp eq i64 %33, 600
  br i1 %34, label %9, label %12, !llvm.loop !16
}

; Function Attrs: nounwind optsize uwtable
define dso_local void @paint_field() local_unnamed_addr #2 {
  br label %1

1:                                                ; preds = %0, %6
  %2 = phi i64 [ 0, %0 ], [ %7, %6 ]
  %3 = trunc i64 %2 to i32
  %4 = trunc i64 %2 to i32
  br label %9

5:                                                ; preds = %6
  ret void

6:                                                ; preds = %21
  %7 = add nuw nsw i64 %2, 1
  %8 = icmp eq i64 %7, 800
  br i1 %8, label %5, label %1, !llvm.loop !17

9:                                                ; preds = %1, %21
  %10 = phi i64 [ 0, %1 ], [ %22, %21 ]
  %11 = load i32, ptr @t, align 4, !tbaa !5
  %12 = zext nneg i32 %11 to i64
  %13 = mul nuw nsw i64 %10, 600
  %14 = add nuw nsw i64 %13, %2
  %15 = getelementptr inbounds [2 x [480000 x i8]], ptr @data, i64 0, i64 %12, i64 %14
  %16 = load i8, ptr %15, align 1, !tbaa !9
  %17 = icmp eq i8 %16, 0
  %18 = trunc i64 %10 to i32
  br i1 %17, label %20, label %19

19:                                               ; preds = %9
  tail call void @sim_draw_color(i32 noundef %3, i32 noundef %18, i32 noundef -1) #7
  br label %21

20:                                               ; preds = %9
  tail call void @sim_draw_color(i32 noundef %4, i32 noundef %18, i32 noundef -16777216) #7
  br label %21

21:                                               ; preds = %19, %20
  %22 = add nuw nsw i64 %10, 1
  %23 = icmp eq i64 %22, 600
  br i1 %23, label %6, label %9, !llvm.loop !18
}

; Function Attrs: optsize
declare void @sim_draw_color(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #3

; Function Attrs: noreturn nounwind optsize uwtable
define dso_local void @app() local_unnamed_addr #6 {
  tail call void @generate_field() #8
  br label %1

1:                                                ; preds = %0, %1
  %2 = load i32, ptr @t, align 4, !tbaa !5
  %3 = icmp eq i32 %2, 0
  %4 = zext i1 %3 to i32
  store i32 %4, ptr @t, align 4, !tbaa !5
  tail call void @update_field() #8
  tail call void @paint_field() #8
  tail call void (...) @sim_flush() #7
  br label %1
}

; Function Attrs: optsize
declare void @sim_flush(...) local_unnamed_addr #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(read, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(readwrite, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind optsize uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree norecurse nosync nounwind optsize memory(read, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree norecurse nosync nounwind optsize memory(readwrite, argmem: read, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { noreturn nounwind optsize uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind optsize }
attributes #8 = { optsize }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!7, !7, i64 0}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = distinct !{!12, !11}
!13 = distinct !{!13, !11}
!14 = distinct !{!14, !11}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
