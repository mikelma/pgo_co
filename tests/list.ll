; ModuleID = 'tests/se-llist/list.c'
source_filename = "tests/se-llist/list.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.llist = type { i64, %struct.elem*, %struct.elem*, [512 x i64], [512 x %struct.elem*], i64 }
%struct.elem = type { i8*, %struct.elem* }

@.str.1 = private unnamed_addr constant [15 x i8] c" * Size:  %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [14 x i8] c" * First: %p\0A\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c" * Last:  %p\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"   - indexes: [\00", align 1
@.str.6 = private unnamed_addr constant [6 x i8] c" %ld \00", align 1
@.str.7 = private unnamed_addr constant [16 x i8] c"]\0A    - ptrs: [\00", align 1
@.str.8 = private unnamed_addr constant [5 x i8] c" %p \00", align 1
@.str.9 = private unnamed_addr constant [23 x i8] c"]\0A    - position: %ld\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"\0AList:\00", align 1
@str.11 = private unnamed_addr constant [10 x i8] c" * Cache:\00", align 1

; Function Attrs: nofree norecurse nounwind uwtable writeonly
define dso_local void @list_initialize(%struct.llist* nocapture %0, i32 %1) local_unnamed_addr #0 !prof !40 {
  %3 = getelementptr %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 0
  %4 = bitcast i64* %3 to i8*
  %5 = bitcast %struct.llist* %0 to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %5, i8 0, i64 24, i1 false)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(4096) %4, i8 -1, i64 4096, i1 false)
  br label %6

6:                                                ; preds = %6, %2
  %7 = phi i64 [ 0, %2 ], [ %47, %6 ]
  %8 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %7
  %9 = bitcast %struct.elem** %8 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %9, align 8, !tbaa !41
  %10 = getelementptr inbounds %struct.elem*, %struct.elem** %8, i64 2
  %11 = bitcast %struct.elem** %10 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %11, align 8, !tbaa !41
  %12 = or i64 %7, 4
  %13 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %12
  %14 = bitcast %struct.elem** %13 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %14, align 8, !tbaa !41
  %15 = getelementptr inbounds %struct.elem*, %struct.elem** %13, i64 2
  %16 = bitcast %struct.elem** %15 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %16, align 8, !tbaa !41
  %17 = or i64 %7, 8
  %18 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %17
  %19 = bitcast %struct.elem** %18 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %19, align 8, !tbaa !41
  %20 = getelementptr inbounds %struct.elem*, %struct.elem** %18, i64 2
  %21 = bitcast %struct.elem** %20 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %21, align 8, !tbaa !41
  %22 = or i64 %7, 12
  %23 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %22
  %24 = bitcast %struct.elem** %23 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %24, align 8, !tbaa !41
  %25 = getelementptr inbounds %struct.elem*, %struct.elem** %23, i64 2
  %26 = bitcast %struct.elem** %25 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %26, align 8, !tbaa !41
  %27 = or i64 %7, 16
  %28 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %27
  %29 = bitcast %struct.elem** %28 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %29, align 8, !tbaa !41
  %30 = getelementptr inbounds %struct.elem*, %struct.elem** %28, i64 2
  %31 = bitcast %struct.elem** %30 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %31, align 8, !tbaa !41
  %32 = or i64 %7, 20
  %33 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %32
  %34 = bitcast %struct.elem** %33 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %34, align 8, !tbaa !41
  %35 = getelementptr inbounds %struct.elem*, %struct.elem** %33, i64 2
  %36 = bitcast %struct.elem** %35 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %36, align 8, !tbaa !41
  %37 = or i64 %7, 24
  %38 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %37
  %39 = bitcast %struct.elem** %38 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %39, align 8, !tbaa !41
  %40 = getelementptr inbounds %struct.elem*, %struct.elem** %38, i64 2
  %41 = bitcast %struct.elem** %40 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %41, align 8, !tbaa !41
  %42 = or i64 %7, 28
  %43 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %42
  %44 = bitcast %struct.elem** %43 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %44, align 8, !tbaa !41
  %45 = getelementptr inbounds %struct.elem*, %struct.elem** %43, i64 2
  %46 = bitcast %struct.elem** %45 to <2 x %struct.elem*>*
  store <2 x %struct.elem*> zeroinitializer, <2 x %struct.elem*>* %46, align 8, !tbaa !41
  %47 = add nuw nsw i64 %7, 32
  %48 = icmp eq i64 %47, 512
  br i1 %48, label %49, label %6, !prof !45, !llvm.loop !46

49:                                               ; preds = %6
  %50 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  store i64 -1, i64* %50, align 8, !tbaa !49
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local void @list_destroy(%struct.llist* nocapture readonly %0) local_unnamed_addr #2 !prof !40 {
  %2 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %3 = load %struct.elem*, %struct.elem** %2, align 8, !tbaa !52
  %4 = icmp eq %struct.elem* %3, null
  br i1 %4, label %11, label %5, !prof !53

5:                                                ; preds = %1, %5
  %6 = phi %struct.elem* [ %8, %5 ], [ %3, %1 ]
  %7 = getelementptr inbounds %struct.elem, %struct.elem* %6, i64 0, i32 1
  %8 = load %struct.elem*, %struct.elem** %7, align 8, !tbaa !54
  %9 = bitcast %struct.elem* %6 to i8*
  tail call void @free(i8* %9) #12
  %10 = icmp eq %struct.elem* %8, null
  br i1 %10, label %11, label %5, !prof !53, !llvm.loop !56

11:                                               ; preds = %5, %1
  ret void
}

; Function Attrs: inaccessiblemem_or_argmemonly nounwind willreturn
declare dso_local void @free(i8* nocapture noundef) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly uwtable willreturn
define dso_local i64 @list_length(%struct.llist* nocapture readonly %0) local_unnamed_addr #4 !prof !57 {
  %2 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 0
  %3 = load i64, i64* %2, align 8, !tbaa !58
  ret i64 %3
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @list_insert_i(%struct.llist* nocapture %0, i64 %1, i8* %2) local_unnamed_addr #5 !prof !59 {
  %4 = alloca %struct.elem*, align 8
  %5 = bitcast %struct.elem** %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %5) #12
  %6 = icmp slt i64 %1, -1
  br i1 %6, label %95, label %7, !prof !60

7:                                                ; preds = %3
  %8 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !58
  %10 = icmp slt i64 %9, %1
  br i1 %10, label %95, label %11, !prof !60

11:                                               ; preds = %7
  %12 = tail call noalias dereferenceable_or_null(16) i8* @malloc(i64 16) #12
  %13 = bitcast i8* %12 to i8**
  store i8* %2, i8** %13, align 8, !tbaa !61
  %14 = icmp eq i64 %9, %1
  %15 = icmp eq i64 %1, -1
  %16 = or i1 %15, %14
  br i1 %16, label %17, label %32, !prof !62

17:                                               ; preds = %11
  %18 = getelementptr inbounds i8, i8* %12, i64 8
  %19 = bitcast i8* %18 to %struct.elem**
  store %struct.elem* null, %struct.elem** %19, align 8, !tbaa !54
  %20 = icmp eq i64 %9, 0
  br i1 %20, label %21, label %23, !prof !63

21:                                               ; preds = %17
  %22 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  br label %27

23:                                               ; preds = %17
  %24 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %25 = load %struct.elem*, %struct.elem** %24, align 8, !tbaa !64
  %26 = getelementptr inbounds %struct.elem, %struct.elem* %25, i64 0, i32 1
  br label %27

27:                                               ; preds = %23, %21
  %28 = phi %struct.elem** [ %26, %23 ], [ %22, %21 ]
  %29 = bitcast %struct.elem** %28 to i8**
  store i8* %12, i8** %29, align 8, !tbaa !41
  %30 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %31 = bitcast %struct.elem** %30 to i8**
  store i8* %12, i8** %31, align 8, !tbaa !64
  br label %92

32:                                               ; preds = %11
  %33 = icmp eq i64 %1, 0
  br i1 %33, label %34, label %65, !prof !65

34:                                               ; preds = %32
  %35 = icmp eq i64 %9, 0
  %36 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  br i1 %35, label %37, label %43, !prof !66

37:                                               ; preds = %34
  %38 = bitcast %struct.elem** %36 to i8**
  store i8* %12, i8** %38, align 8, !tbaa !52
  %39 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %40 = bitcast %struct.elem** %39 to i8**
  store i8* %12, i8** %40, align 8, !tbaa !64
  %41 = getelementptr inbounds i8, i8* %12, i64 8
  %42 = bitcast i8* %41 to %struct.elem**
  store %struct.elem* null, %struct.elem** %42, align 8, !tbaa !54
  br label %92

43:                                               ; preds = %34
  %44 = load %struct.elem*, %struct.elem** %36, align 8, !tbaa !52
  %45 = getelementptr inbounds i8, i8* %12, i64 8
  %46 = bitcast i8* %45 to %struct.elem**
  store %struct.elem* %44, %struct.elem** %46, align 8, !tbaa !54
  %47 = bitcast %struct.elem** %36 to i8**
  store i8* %12, i8** %47, align 8, !tbaa !52
  %48 = add nsw i64 %9, -1
  br label %49

49:                                               ; preds = %102, %43
  %50 = phi i64 [ 0, %43 ], [ %103, %102 ]
  %51 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %50
  %52 = load i64, i64* %51, align 8, !tbaa !67
  %53 = icmp eq i64 %52, %48
  br i1 %53, label %58, label %54, !prof !68

54:                                               ; preds = %49
  %55 = icmp sgt i64 %52, -1
  br i1 %55, label %56, label %60, !prof !69

56:                                               ; preds = %54
  %57 = add nuw nsw i64 %52, 1
  br label %58

58:                                               ; preds = %49, %56
  %59 = phi i64 [ %57, %56 ], [ -2, %49 ]
  store i64 %59, i64* %51, align 8, !tbaa !67
  br label %60

60:                                               ; preds = %58, %54
  %61 = or i64 %50, 1
  %62 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %61
  %63 = load i64, i64* %62, align 8, !tbaa !67
  %64 = icmp eq i64 %63, %48
  br i1 %64, label %100, label %96, !prof !68

65:                                               ; preds = %32
  %66 = add nsw i64 %1, -1
  %67 = call i32 @_list_get_elem(%struct.llist* nonnull %0, i64 %66, %struct.elem** nonnull %4, i1 zeroext true)
  %68 = load %struct.elem*, %struct.elem** %4, align 8, !tbaa !41
  %69 = getelementptr inbounds %struct.elem, %struct.elem* %68, i64 0, i32 1
  %70 = load %struct.elem*, %struct.elem** %69, align 8, !tbaa !54
  %71 = bitcast %struct.elem** %69 to i8**
  store i8* %12, i8** %71, align 8, !tbaa !54
  %72 = getelementptr inbounds i8, i8* %12, i64 8
  %73 = bitcast i8* %72 to %struct.elem**
  store %struct.elem* %70, %struct.elem** %73, align 8, !tbaa !54
  %74 = load i64, i64* %8, align 8, !tbaa !58
  %75 = add nsw i64 %74, -1
  br label %76

76:                                               ; preds = %111, %65
  %77 = phi i64 [ 0, %65 ], [ %112, %111 ]
  %78 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %77
  %79 = load i64, i64* %78, align 8, !tbaa !67
  %80 = icmp eq i64 %79, %75
  br i1 %80, label %85, label %81, !prof !70

81:                                               ; preds = %76
  %82 = icmp slt i64 %79, %1
  br i1 %82, label %87, label %83, !prof !71

83:                                               ; preds = %81
  %84 = add nsw i64 %79, 1
  br label %85

85:                                               ; preds = %76, %83
  %86 = phi i64 [ %84, %83 ], [ -2, %76 ]
  store i64 %86, i64* %78, align 8, !tbaa !67
  br label %87

87:                                               ; preds = %85, %81
  %88 = or i64 %77, 1
  %89 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %88
  %90 = load i64, i64* %89, align 8, !tbaa !67
  %91 = icmp eq i64 %90, %75
  br i1 %91, label %109, label %105, !prof !70

92:                                               ; preds = %111, %102, %37, %27
  %93 = phi i64 [ 0, %37 ], [ %9, %27 ], [ %9, %102 ], [ %74, %111 ]
  %94 = add nsw i64 %93, 1
  store i64 %94, i64* %8, align 8, !tbaa !58
  br label %95

95:                                               ; preds = %3, %7, %92
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %5) #12
  ret void

96:                                               ; preds = %60
  %97 = icmp sgt i64 %63, -1
  br i1 %97, label %98, label %102, !prof !69

98:                                               ; preds = %96
  %99 = add nuw nsw i64 %63, 1
  br label %100

100:                                              ; preds = %98, %60
  %101 = phi i64 [ %99, %98 ], [ -2, %60 ]
  store i64 %101, i64* %62, align 8, !tbaa !67
  br label %102

102:                                              ; preds = %100, %96
  %103 = add nuw nsw i64 %50, 2
  %104 = icmp eq i64 %103, 512
  br i1 %104, label %92, label %49, !prof !72, !llvm.loop !73

105:                                              ; preds = %87
  %106 = icmp slt i64 %90, %1
  br i1 %106, label %111, label %107, !prof !71

107:                                              ; preds = %105
  %108 = add nsw i64 %90, 1
  br label %109

109:                                              ; preds = %107, %87
  %110 = phi i64 [ %108, %107 ], [ -2, %87 ]
  store i64 %110, i64* %89, align 8, !tbaa !67
  br label %111

111:                                              ; preds = %109, %105
  %112 = add nuw nsw i64 %77, 2
  %113 = icmp eq i64 %112, 512
  br i1 %113, label %92, label %76, !prof !74, !llvm.loop !75
}

; Function Attrs: inaccessiblememonly nofree nounwind willreturn
declare dso_local noalias noundef i8* @malloc(i64) local_unnamed_addr #6

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local i32 @_list_get_elem(%struct.llist* nocapture %0, i64 %1, %struct.elem** nocapture %2, i1 zeroext %3) local_unnamed_addr #7 !prof !76 {
  %5 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 0
  %6 = load i64, i64* %5, align 8, !tbaa !58
  %7 = icmp sle i64 %6, %1
  %8 = icmp slt i64 %1, -1
  %9 = or i1 %8, %7
  br i1 %9, label %188, label %10, !prof !77

10:                                               ; preds = %4
  switch i64 %1, label %25 [
    i64 0, label %11
    i64 -1, label %28
  ], !prof !78

11:                                               ; preds = %10
  %12 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %13 = load %struct.elem*, %struct.elem** %12, align 8, !tbaa !52
  store %struct.elem* %13, %struct.elem** %2, align 8, !tbaa !41
  br i1 %3, label %14, label %188, !prof !79

14:                                               ; preds = %11
  %15 = load %struct.elem*, %struct.elem** %12, align 8, !tbaa !52
  %16 = getelementptr inbounds %struct.elem, %struct.elem* %15, i64 0, i32 1
  %17 = load %struct.elem*, %struct.elem** %16, align 8, !tbaa !54
  %18 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  %19 = load i64, i64* %18, align 8, !tbaa !49
  %20 = icmp eq i64 %19, 511
  %21 = add nsw i64 %19, 1
  %22 = select i1 %20, i64 0, i64 %21, !prof !80
  store i64 %22, i64* %18, align 8, !tbaa !49
  %23 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %22
  store %struct.elem* %17, %struct.elem** %23, align 8, !tbaa !41
  %24 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %22
  store i64 1, i64* %24, align 8, !tbaa !67
  br label %188

25:                                               ; preds = %10
  %26 = add nsw i64 %6, -1
  %27 = icmp eq i64 %26, %1
  br i1 %27, label %28, label %31, !prof !81

28:                                               ; preds = %10, %25
  %29 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %30 = load %struct.elem*, %struct.elem** %29, align 8, !tbaa !64
  store %struct.elem* %30, %struct.elem** %2, align 8, !tbaa !41
  br label %188

31:                                               ; preds = %25
  store %struct.elem* null, %struct.elem** %2, align 8, !tbaa !41
  %32 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  %33 = load i64, i64* %32, align 8, !tbaa !49
  %34 = icmp eq i64 %33, -1
  br i1 %34, label %35, label %38, !prof !82

35:                                               ; preds = %31
  %36 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %37 = load %struct.elem*, %struct.elem** %36, align 8, !tbaa !41
  br label %133

38:                                               ; preds = %31, %70
  %39 = phi i64 [ %74, %70 ], [ -1, %31 ]
  %40 = phi i64 [ %73, %70 ], [ 0, %31 ]
  %41 = phi i64 [ %72, %70 ], [ 0, %31 ]
  %42 = phi i64 [ %71, %70 ], [ %33, %31 ]
  %43 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %42
  %44 = load i64, i64* %43, align 8, !tbaa !67
  switch i64 %44, label %55 [
    i64 -1, label %45
    i64 -2, label %50
  ], !prof !83

45:                                               ; preds = %38
  %46 = icmp eq i64 %42, 0
  br i1 %46, label %76, label %47, !prof !84

47:                                               ; preds = %45
  %48 = add nsw i64 %41, 511
  %49 = sub i64 %48, %42
  br label %70

50:                                               ; preds = %38
  %51 = icmp eq i64 %42, 511
  %52 = add nsw i64 %42, 1
  %53 = select i1 %51, i64 0, i64 %52, !prof !85
  %54 = add nsw i64 %41, 1
  br label %70

55:                                               ; preds = %38
  %56 = icmp eq i64 %44, %1
  br i1 %56, label %57, label %60, !prof !86

57:                                               ; preds = %55
  %58 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %42
  %59 = load %struct.elem*, %struct.elem** %58, align 8, !tbaa !41
  store %struct.elem* %59, %struct.elem** %2, align 8, !tbaa !41
  br label %126

60:                                               ; preds = %55
  %61 = icmp slt i64 %44, %1
  %62 = icmp sgt i64 %44, %40
  %63 = and i1 %61, %62
  %64 = select i1 %63, i64 %44, i64 %40, !prof !87
  %65 = select i1 %63, i64 %42, i64 %39, !prof !87
  %66 = icmp eq i64 %42, 511
  %67 = add nsw i64 %42, 1
  %68 = select i1 %66, i64 0, i64 %67, !prof !88
  %69 = add nsw i64 %41, 1
  br label %70

70:                                               ; preds = %60, %50, %47
  %71 = phi i64 [ 0, %47 ], [ %53, %50 ], [ %68, %60 ]
  %72 = phi i64 [ %49, %47 ], [ %54, %50 ], [ %69, %60 ]
  %73 = phi i64 [ %40, %47 ], [ %40, %50 ], [ %64, %60 ]
  %74 = phi i64 [ %39, %47 ], [ %39, %50 ], [ %65, %60 ]
  %75 = icmp slt i64 %72, 512
  br i1 %75, label %38, label %76, !prof !89, !llvm.loop !90

76:                                               ; preds = %70, %45
  %77 = phi i64 [ %74, %70 ], [ %39, %45 ]
  %78 = phi i64 [ %73, %70 ], [ %40, %45 ]
  %79 = icmp sgt i64 %77, -1
  %80 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %81 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %77
  %82 = select i1 %79, %struct.elem** %81, %struct.elem** %80, !prof !91
  %83 = load %struct.elem*, %struct.elem** %82, align 8, !tbaa !41
  store %struct.elem* %83, %struct.elem** %2, align 8, !tbaa !41
  %84 = icmp slt i64 %78, %1
  br i1 %84, label %85, label %126, !prof !92

85:                                               ; preds = %76
  %86 = sub i64 %1, %78
  %87 = xor i64 %78, -1
  %88 = add i64 %87, %1
  %89 = and i64 %86, 7
  %90 = icmp eq i64 %89, 0
  br i1 %90, label %100, label %91

91:                                               ; preds = %85, %91
  %92 = phi %struct.elem* [ %96, %91 ], [ %83, %85 ]
  %93 = phi i64 [ %97, %91 ], [ %78, %85 ]
  %94 = phi i64 [ %98, %91 ], [ %89, %85 ]
  %95 = getelementptr inbounds %struct.elem, %struct.elem* %92, i64 0, i32 1
  %96 = load %struct.elem*, %struct.elem** %95, align 8, !tbaa !54
  store %struct.elem* %96, %struct.elem** %2, align 8, !tbaa !41
  %97 = add nsw i64 %93, 1
  %98 = add i64 %94, -1
  %99 = icmp eq i64 %98, 0
  br i1 %99, label %100, label %91, !prof !93, !llvm.loop !94

100:                                              ; preds = %91, %85
  %101 = phi %struct.elem* [ undef, %85 ], [ %96, %91 ]
  %102 = phi %struct.elem* [ %83, %85 ], [ %96, %91 ]
  %103 = phi i64 [ %78, %85 ], [ %97, %91 ]
  %104 = icmp ult i64 %88, 7
  br i1 %104, label %126, label %105

105:                                              ; preds = %100, %105
  %106 = phi %struct.elem* [ %123, %105 ], [ %102, %100 ]
  %107 = phi i64 [ %124, %105 ], [ %103, %100 ]
  %108 = getelementptr inbounds %struct.elem, %struct.elem* %106, i64 0, i32 1
  %109 = load %struct.elem*, %struct.elem** %108, align 8, !tbaa !54
  store %struct.elem* %109, %struct.elem** %2, align 8, !tbaa !41
  %110 = getelementptr inbounds %struct.elem, %struct.elem* %109, i64 0, i32 1
  %111 = load %struct.elem*, %struct.elem** %110, align 8, !tbaa !54
  store %struct.elem* %111, %struct.elem** %2, align 8, !tbaa !41
  %112 = getelementptr inbounds %struct.elem, %struct.elem* %111, i64 0, i32 1
  %113 = load %struct.elem*, %struct.elem** %112, align 8, !tbaa !54
  store %struct.elem* %113, %struct.elem** %2, align 8, !tbaa !41
  %114 = getelementptr inbounds %struct.elem, %struct.elem* %113, i64 0, i32 1
  %115 = load %struct.elem*, %struct.elem** %114, align 8, !tbaa !54
  store %struct.elem* %115, %struct.elem** %2, align 8, !tbaa !41
  %116 = getelementptr inbounds %struct.elem, %struct.elem* %115, i64 0, i32 1
  %117 = load %struct.elem*, %struct.elem** %116, align 8, !tbaa !54
  store %struct.elem* %117, %struct.elem** %2, align 8, !tbaa !41
  %118 = getelementptr inbounds %struct.elem, %struct.elem* %117, i64 0, i32 1
  %119 = load %struct.elem*, %struct.elem** %118, align 8, !tbaa !54
  store %struct.elem* %119, %struct.elem** %2, align 8, !tbaa !41
  %120 = getelementptr inbounds %struct.elem, %struct.elem* %119, i64 0, i32 1
  %121 = load %struct.elem*, %struct.elem** %120, align 8, !tbaa !54
  store %struct.elem* %121, %struct.elem** %2, align 8, !tbaa !41
  %122 = getelementptr inbounds %struct.elem, %struct.elem* %121, i64 0, i32 1
  %123 = load %struct.elem*, %struct.elem** %122, align 8, !tbaa !54
  store %struct.elem* %123, %struct.elem** %2, align 8, !tbaa !41
  %124 = add nsw i64 %107, 8
  %125 = icmp eq i64 %124, %1
  br i1 %125, label %126, label %105, !prof !96, !llvm.loop !97

126:                                              ; preds = %100, %105, %57, %76
  %127 = phi %struct.elem* [ %59, %57 ], [ %83, %76 ], [ %101, %100 ], [ %123, %105 ]
  %128 = icmp eq %struct.elem* %127, null
  br i1 %128, label %129, label %174, !prof !98

129:                                              ; preds = %126
  %130 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %131 = load %struct.elem*, %struct.elem** %130, align 8, !tbaa !41
  %132 = icmp sgt i64 %1, 0
  br i1 %132, label %133, label %172, !prof !99

133:                                              ; preds = %35, %129
  %134 = phi %struct.elem* [ %131, %129 ], [ %37, %35 ]
  %135 = add i64 %1, -1
  %136 = and i64 %1, 7
  %137 = icmp ult i64 %135, 7
  br i1 %137, label %161, label %138

138:                                              ; preds = %133
  %139 = and i64 %1, -8
  br label %140

140:                                              ; preds = %140, %138
  %141 = phi %struct.elem* [ %134, %138 ], [ %158, %140 ]
  %142 = phi i64 [ %139, %138 ], [ %159, %140 ]
  %143 = getelementptr inbounds %struct.elem, %struct.elem* %141, i64 0, i32 1
  %144 = load %struct.elem*, %struct.elem** %143, align 8, !tbaa !41
  %145 = getelementptr inbounds %struct.elem, %struct.elem* %144, i64 0, i32 1
  %146 = load %struct.elem*, %struct.elem** %145, align 8, !tbaa !41
  %147 = getelementptr inbounds %struct.elem, %struct.elem* %146, i64 0, i32 1
  %148 = load %struct.elem*, %struct.elem** %147, align 8, !tbaa !41
  %149 = getelementptr inbounds %struct.elem, %struct.elem* %148, i64 0, i32 1
  %150 = load %struct.elem*, %struct.elem** %149, align 8, !tbaa !41
  %151 = getelementptr inbounds %struct.elem, %struct.elem* %150, i64 0, i32 1
  %152 = load %struct.elem*, %struct.elem** %151, align 8, !tbaa !41
  %153 = getelementptr inbounds %struct.elem, %struct.elem* %152, i64 0, i32 1
  %154 = load %struct.elem*, %struct.elem** %153, align 8, !tbaa !41
  %155 = getelementptr inbounds %struct.elem, %struct.elem* %154, i64 0, i32 1
  %156 = load %struct.elem*, %struct.elem** %155, align 8, !tbaa !41
  %157 = getelementptr inbounds %struct.elem, %struct.elem* %156, i64 0, i32 1
  %158 = load %struct.elem*, %struct.elem** %157, align 8, !tbaa !41
  %159 = add i64 %142, -8
  %160 = icmp eq i64 %159, 0
  br i1 %160, label %161, label %140, !prof !100, !llvm.loop !101

161:                                              ; preds = %140, %133
  %162 = phi %struct.elem* [ undef, %133 ], [ %158, %140 ]
  %163 = phi %struct.elem* [ %134, %133 ], [ %158, %140 ]
  %164 = icmp eq i64 %136, 0
  br i1 %164, label %172, label %165

165:                                              ; preds = %161, %165
  %166 = phi %struct.elem* [ %169, %165 ], [ %163, %161 ]
  %167 = phi i64 [ %170, %165 ], [ %136, %161 ]
  %168 = getelementptr inbounds %struct.elem, %struct.elem* %166, i64 0, i32 1
  %169 = load %struct.elem*, %struct.elem** %168, align 8, !tbaa !41
  %170 = add i64 %167, -1
  %171 = icmp eq i64 %170, 0
  br i1 %171, label %172, label %165, !prof !102, !llvm.loop !103

172:                                              ; preds = %161, %165, %129
  %173 = phi %struct.elem* [ %131, %129 ], [ %162, %161 ], [ %169, %165 ]
  store %struct.elem* %173, %struct.elem** %2, align 8, !tbaa !41
  br label %174

174:                                              ; preds = %172, %126
  %175 = phi %struct.elem* [ %173, %172 ], [ %127, %126 ]
  %176 = add nsw i64 %6, -2
  %177 = icmp ne i64 %176, %1
  %178 = and i1 %177, %3
  br i1 %178, label %179, label %188, !prof !104

179:                                              ; preds = %174
  %180 = add nsw i64 %1, 1
  %181 = getelementptr inbounds %struct.elem, %struct.elem* %175, i64 0, i32 1
  %182 = load %struct.elem*, %struct.elem** %181, align 8, !tbaa !54
  %183 = icmp eq i64 %33, 511
  %184 = add nsw i64 %33, 1
  %185 = select i1 %183, i64 0, i64 %184, !prof !80
  store i64 %185, i64* %32, align 8, !tbaa !49
  %186 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %185
  store %struct.elem* %182, %struct.elem** %186, align 8, !tbaa !41
  %187 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %185
  store i64 %180, i64* %187, align 8, !tbaa !67
  br label %188

188:                                              ; preds = %14, %11, %174, %179, %28, %4
  %189 = phi i32 [ 1, %4 ], [ 0, %28 ], [ 0, %179 ], [ 0, %174 ], [ 0, %11 ], [ 0, %14 ]
  ret i32 %189
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @list_get_i(%struct.llist* nocapture %0, i64 %1, i8** nocapture %2) local_unnamed_addr #5 !prof !105 {
  %4 = alloca %struct.elem*, align 8
  %5 = bitcast %struct.elem** %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %5) #12
  %6 = call i32 @_list_get_elem(%struct.llist* %0, i64 %1, %struct.elem** nonnull %4, i1 zeroext true)
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %12, !prof !106

8:                                                ; preds = %3
  %9 = load %struct.elem*, %struct.elem** %4, align 8, !tbaa !41
  %10 = getelementptr inbounds %struct.elem, %struct.elem* %9, i64 0, i32 0
  %11 = load i8*, i8** %10, align 8, !tbaa !61
  store i8* %11, i8** %2, align 8, !tbaa !41
  br label %12

12:                                               ; preds = %8, %3
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %5) #12
  ret void
}

; Function Attrs: nofree norecurse nounwind uwtable willreturn
define dso_local void @_list_cache_update(%struct.llist* nocapture %0, i64 %1, %struct.elem* %2) local_unnamed_addr #8 !prof !107 {
  %4 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  %5 = load i64, i64* %4, align 8, !tbaa !49
  %6 = icmp eq i64 %5, 511
  %7 = add nsw i64 %5, 1
  %8 = select i1 %6, i64 0, i64 %7, !prof !80
  store i64 %8, i64* %4, align 8, !tbaa !49
  %9 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %8
  store %struct.elem* %2, %struct.elem** %9, align 8, !tbaa !41
  %10 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %8
  store i64 %1, i64* %10, align 8, !tbaa !67
  ret void
}

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local void @_list_cache_search(%struct.llist* nocapture readonly %0, i64 %1, %struct.elem** nocapture %2) local_unnamed_addr #7 !prof !108 {
  store %struct.elem* null, %struct.elem** %2, align 8, !tbaa !41
  %4 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  %5 = load i64, i64* %4, align 8, !tbaa !49
  %6 = icmp eq i64 %5, -1
  br i1 %6, label %94, label %7, !prof !82

7:                                                ; preds = %3, %39
  %8 = phi i64 [ %43, %39 ], [ -1, %3 ]
  %9 = phi i64 [ %42, %39 ], [ 0, %3 ]
  %10 = phi i64 [ %41, %39 ], [ 0, %3 ]
  %11 = phi i64 [ %40, %39 ], [ %5, %3 ]
  %12 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %11
  %13 = load i64, i64* %12, align 8, !tbaa !67
  switch i64 %13, label %24 [
    i64 -1, label %14
    i64 -2, label %19
  ], !prof !83

14:                                               ; preds = %7
  %15 = icmp eq i64 %11, 0
  br i1 %15, label %45, label %16, !prof !84

16:                                               ; preds = %14
  %17 = sub i64 511, %11
  %18 = add nsw i64 %17, %10
  br label %39

19:                                               ; preds = %7
  %20 = icmp eq i64 %11, 511
  %21 = add nsw i64 %11, 1
  %22 = select i1 %20, i64 0, i64 %21, !prof !85
  %23 = add nsw i64 %10, 1
  br label %39

24:                                               ; preds = %7
  %25 = icmp eq i64 %13, %1
  br i1 %25, label %26, label %29, !prof !86

26:                                               ; preds = %24
  %27 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %11
  %28 = load %struct.elem*, %struct.elem** %27, align 8, !tbaa !41
  store %struct.elem* %28, %struct.elem** %2, align 8, !tbaa !41
  br label %94

29:                                               ; preds = %24
  %30 = icmp slt i64 %13, %1
  %31 = icmp sgt i64 %13, %9
  %32 = and i1 %30, %31
  %33 = select i1 %32, i64 %13, i64 %9, !prof !87
  %34 = select i1 %32, i64 %11, i64 %8, !prof !87
  %35 = icmp eq i64 %11, 511
  %36 = add nsw i64 %11, 1
  %37 = select i1 %35, i64 0, i64 %36, !prof !88
  %38 = add nsw i64 %10, 1
  br label %39

39:                                               ; preds = %19, %29, %16
  %40 = phi i64 [ 0, %16 ], [ %22, %19 ], [ %37, %29 ]
  %41 = phi i64 [ %18, %16 ], [ %23, %19 ], [ %38, %29 ]
  %42 = phi i64 [ %9, %16 ], [ %9, %19 ], [ %33, %29 ]
  %43 = phi i64 [ %8, %16 ], [ %8, %19 ], [ %34, %29 ]
  %44 = icmp slt i64 %41, 512
  br i1 %44, label %7, label %45, !prof !89, !llvm.loop !90

45:                                               ; preds = %14, %39
  %46 = phi i64 [ %43, %39 ], [ %8, %14 ]
  %47 = phi i64 [ %42, %39 ], [ %9, %14 ]
  %48 = icmp sgt i64 %46, -1
  %49 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %50 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %46
  %51 = select i1 %48, %struct.elem** %50, %struct.elem** %49, !prof !91
  %52 = load %struct.elem*, %struct.elem** %51, align 8, !tbaa !41
  store %struct.elem* %52, %struct.elem** %2, align 8, !tbaa !41
  %53 = icmp slt i64 %47, %1
  br i1 %53, label %54, label %94, !prof !92

54:                                               ; preds = %45
  %55 = sub i64 %1, %47
  %56 = xor i64 %47, -1
  %57 = add i64 %56, %1
  %58 = and i64 %55, 7
  %59 = icmp eq i64 %58, 0
  br i1 %59, label %69, label %60

60:                                               ; preds = %54, %60
  %61 = phi %struct.elem* [ %65, %60 ], [ %52, %54 ]
  %62 = phi i64 [ %66, %60 ], [ %47, %54 ]
  %63 = phi i64 [ %67, %60 ], [ %58, %54 ]
  %64 = getelementptr inbounds %struct.elem, %struct.elem* %61, i64 0, i32 1
  %65 = load %struct.elem*, %struct.elem** %64, align 8, !tbaa !54
  store %struct.elem* %65, %struct.elem** %2, align 8, !tbaa !41
  %66 = add nsw i64 %62, 1
  %67 = add i64 %63, -1
  %68 = icmp eq i64 %67, 0
  br i1 %68, label %69, label %60, !prof !93, !llvm.loop !109

69:                                               ; preds = %60, %54
  %70 = phi %struct.elem* [ %52, %54 ], [ %65, %60 ]
  %71 = phi i64 [ %47, %54 ], [ %66, %60 ]
  %72 = icmp ult i64 %57, 7
  br i1 %72, label %94, label %73

73:                                               ; preds = %69, %73
  %74 = phi %struct.elem* [ %91, %73 ], [ %70, %69 ]
  %75 = phi i64 [ %92, %73 ], [ %71, %69 ]
  %76 = getelementptr inbounds %struct.elem, %struct.elem* %74, i64 0, i32 1
  %77 = load %struct.elem*, %struct.elem** %76, align 8, !tbaa !54
  store %struct.elem* %77, %struct.elem** %2, align 8, !tbaa !41
  %78 = getelementptr inbounds %struct.elem, %struct.elem* %77, i64 0, i32 1
  %79 = load %struct.elem*, %struct.elem** %78, align 8, !tbaa !54
  store %struct.elem* %79, %struct.elem** %2, align 8, !tbaa !41
  %80 = getelementptr inbounds %struct.elem, %struct.elem* %79, i64 0, i32 1
  %81 = load %struct.elem*, %struct.elem** %80, align 8, !tbaa !54
  store %struct.elem* %81, %struct.elem** %2, align 8, !tbaa !41
  %82 = getelementptr inbounds %struct.elem, %struct.elem* %81, i64 0, i32 1
  %83 = load %struct.elem*, %struct.elem** %82, align 8, !tbaa !54
  store %struct.elem* %83, %struct.elem** %2, align 8, !tbaa !41
  %84 = getelementptr inbounds %struct.elem, %struct.elem* %83, i64 0, i32 1
  %85 = load %struct.elem*, %struct.elem** %84, align 8, !tbaa !54
  store %struct.elem* %85, %struct.elem** %2, align 8, !tbaa !41
  %86 = getelementptr inbounds %struct.elem, %struct.elem* %85, i64 0, i32 1
  %87 = load %struct.elem*, %struct.elem** %86, align 8, !tbaa !54
  store %struct.elem* %87, %struct.elem** %2, align 8, !tbaa !41
  %88 = getelementptr inbounds %struct.elem, %struct.elem* %87, i64 0, i32 1
  %89 = load %struct.elem*, %struct.elem** %88, align 8, !tbaa !54
  store %struct.elem* %89, %struct.elem** %2, align 8, !tbaa !41
  %90 = getelementptr inbounds %struct.elem, %struct.elem* %89, i64 0, i32 1
  %91 = load %struct.elem*, %struct.elem** %90, align 8, !tbaa !54
  store %struct.elem* %91, %struct.elem** %2, align 8, !tbaa !41
  %92 = add nsw i64 %75, 8
  %93 = icmp eq i64 %92, %1
  br i1 %93, label %94, label %73, !prof !96, !llvm.loop !97

94:                                               ; preds = %69, %73, %26, %3, %45
  ret void
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @list_set_i(%struct.llist* nocapture %0, i64 %1, i8* %2, i8** nocapture %3) local_unnamed_addr #5 !prof !57 {
  %5 = alloca %struct.elem*, align 8
  %6 = bitcast %struct.elem** %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6) #12
  %7 = call i32 @_list_get_elem(%struct.llist* %0, i64 %1, %struct.elem** nonnull %5, i1 zeroext true)
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %13

9:                                                ; preds = %4
  %10 = load %struct.elem*, %struct.elem** %5, align 8, !tbaa !41
  %11 = getelementptr inbounds %struct.elem, %struct.elem* %10, i64 0, i32 0
  %12 = load i8*, i8** %11, align 8, !tbaa !61
  store i8* %12, i8** %3, align 8, !tbaa !41
  store i8* %2, i8** %11, align 8, !tbaa !61
  br label %13

13:                                               ; preds = %4, %9
  %14 = phi i32 [ 0, %9 ], [ 1, %4 ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6) #12
  ret i32 %14
}

; Function Attrs: nounwind uwtable
define dso_local void @list_rem_i(%struct.llist* %0, i64 %1) local_unnamed_addr #2 !prof !110 {
  %3 = alloca %struct.elem*, align 8
  %4 = bitcast %struct.elem** %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4) #12
  %5 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 0
  %6 = load i64, i64* %5, align 8, !tbaa !58
  %7 = icmp sle i64 %6, %1
  %8 = icmp slt i64 %1, -1
  %9 = or i1 %8, %7
  br i1 %9, label %373, label %10, !prof !111

10:                                               ; preds = %2
  %11 = icmp eq i64 %1, -1
  %12 = add nsw i64 %6, -1
  %13 = select i1 %11, i64 %12, i64 %1, !prof !112
  %14 = icmp eq i64 %13, 0
  br i1 %14, label %15, label %21, !prof !113

15:                                               ; preds = %10
  %16 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %17 = load %struct.elem*, %struct.elem** %16, align 8, !tbaa !52
  %18 = getelementptr inbounds %struct.elem, %struct.elem* %17, i64 0, i32 1
  %19 = load %struct.elem*, %struct.elem** %18, align 8, !tbaa !54
  store %struct.elem* %19, %struct.elem** %16, align 8, !tbaa !52
  %20 = bitcast %struct.elem* %17 to i8*
  tail call void @free(i8* %20) #12
  br label %354

21:                                               ; preds = %10
  %22 = icmp eq i64 %13, %12
  br i1 %22, label %23, label %184, !prof !114

23:                                               ; preds = %21
  %24 = add nsw i64 %6, -2
  %25 = icmp slt i64 %6, 1
  br i1 %25, label %178, label %26, !prof !77

26:                                               ; preds = %23
  switch i64 %6, label %33 [
    i64 2, label %27
    i64 1, label %30
  ], !prof !78

27:                                               ; preds = %26
  %28 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %29 = load %struct.elem*, %struct.elem** %28, align 8, !tbaa !52
  store %struct.elem* %29, %struct.elem** %3, align 8, !tbaa !41
  br label %178

30:                                               ; preds = %26
  %31 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %32 = load %struct.elem*, %struct.elem** %31, align 8, !tbaa !64
  store %struct.elem* %32, %struct.elem** %3, align 8, !tbaa !41
  br label %178

33:                                               ; preds = %26
  %34 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  %35 = load i64, i64* %34, align 8, !tbaa !49
  %36 = icmp eq i64 %35, -1
  br i1 %36, label %37, label %40, !prof !82

37:                                               ; preds = %33
  %38 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %39 = load %struct.elem*, %struct.elem** %38, align 8, !tbaa !41
  br label %136

40:                                               ; preds = %33, %72
  %41 = phi i64 [ %76, %72 ], [ -1, %33 ]
  %42 = phi i64 [ %75, %72 ], [ 0, %33 ]
  %43 = phi i64 [ %74, %72 ], [ 0, %33 ]
  %44 = phi i64 [ %73, %72 ], [ %35, %33 ]
  %45 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %44
  %46 = load i64, i64* %45, align 8, !tbaa !67
  switch i64 %46, label %57 [
    i64 -1, label %47
    i64 -2, label %52
  ], !prof !83

47:                                               ; preds = %40
  %48 = icmp eq i64 %44, 0
  br i1 %48, label %78, label %49, !prof !84

49:                                               ; preds = %47
  %50 = add nsw i64 %43, 511
  %51 = sub i64 %50, %44
  br label %72

52:                                               ; preds = %40
  %53 = icmp eq i64 %44, 511
  %54 = add nsw i64 %44, 1
  %55 = select i1 %53, i64 0, i64 %54, !prof !85
  %56 = add nsw i64 %43, 1
  br label %72

57:                                               ; preds = %40
  %58 = icmp eq i64 %46, %24
  br i1 %58, label %59, label %62, !prof !86

59:                                               ; preds = %57
  %60 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %44
  %61 = load %struct.elem*, %struct.elem** %60, align 8, !tbaa !41
  br label %129

62:                                               ; preds = %57
  %63 = icmp slt i64 %46, %24
  %64 = icmp sgt i64 %46, %42
  %65 = and i1 %63, %64
  %66 = select i1 %65, i64 %46, i64 %42, !prof !87
  %67 = select i1 %65, i64 %44, i64 %41, !prof !87
  %68 = icmp eq i64 %44, 511
  %69 = add nsw i64 %44, 1
  %70 = select i1 %68, i64 0, i64 %69, !prof !88
  %71 = add nsw i64 %43, 1
  br label %72

72:                                               ; preds = %62, %52, %49
  %73 = phi i64 [ 0, %49 ], [ %55, %52 ], [ %70, %62 ]
  %74 = phi i64 [ %51, %49 ], [ %56, %52 ], [ %71, %62 ]
  %75 = phi i64 [ %42, %49 ], [ %42, %52 ], [ %66, %62 ]
  %76 = phi i64 [ %41, %49 ], [ %41, %52 ], [ %67, %62 ]
  %77 = icmp slt i64 %74, 512
  br i1 %77, label %40, label %78, !prof !89, !llvm.loop !90

78:                                               ; preds = %72, %47
  %79 = phi i64 [ %76, %72 ], [ %41, %47 ]
  %80 = phi i64 [ %75, %72 ], [ %42, %47 ]
  %81 = icmp sgt i64 %79, -1
  %82 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %83 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %79
  %84 = select i1 %81, %struct.elem** %83, %struct.elem** %82, !prof !91
  %85 = load %struct.elem*, %struct.elem** %84, align 8, !tbaa !41
  %86 = icmp slt i64 %80, %24
  br i1 %86, label %87, label %129, !prof !92

87:                                               ; preds = %78
  %88 = add i64 %6, 6
  %89 = sub i64 %88, %80
  %90 = add i64 %6, -3
  %91 = sub i64 %90, %80
  %92 = and i64 %89, 7
  %93 = icmp eq i64 %92, 0
  br i1 %93, label %103, label %94

94:                                               ; preds = %87, %94
  %95 = phi %struct.elem* [ %99, %94 ], [ %85, %87 ]
  %96 = phi i64 [ %100, %94 ], [ %80, %87 ]
  %97 = phi i64 [ %101, %94 ], [ %92, %87 ]
  %98 = getelementptr inbounds %struct.elem, %struct.elem* %95, i64 0, i32 1
  %99 = load %struct.elem*, %struct.elem** %98, align 8, !tbaa !54
  %100 = add nsw i64 %96, 1
  %101 = add i64 %97, -1
  %102 = icmp eq i64 %101, 0
  br i1 %102, label %103, label %94, !prof !93, !llvm.loop !115

103:                                              ; preds = %94, %87
  %104 = phi %struct.elem* [ undef, %87 ], [ %99, %94 ]
  %105 = phi %struct.elem* [ %85, %87 ], [ %99, %94 ]
  %106 = phi i64 [ %80, %87 ], [ %100, %94 ]
  %107 = icmp ult i64 %91, 7
  br i1 %107, label %129, label %108

108:                                              ; preds = %103, %108
  %109 = phi %struct.elem* [ %126, %108 ], [ %105, %103 ]
  %110 = phi i64 [ %127, %108 ], [ %106, %103 ]
  %111 = getelementptr inbounds %struct.elem, %struct.elem* %109, i64 0, i32 1
  %112 = load %struct.elem*, %struct.elem** %111, align 8, !tbaa !54
  %113 = getelementptr inbounds %struct.elem, %struct.elem* %112, i64 0, i32 1
  %114 = load %struct.elem*, %struct.elem** %113, align 8, !tbaa !54
  %115 = getelementptr inbounds %struct.elem, %struct.elem* %114, i64 0, i32 1
  %116 = load %struct.elem*, %struct.elem** %115, align 8, !tbaa !54
  %117 = getelementptr inbounds %struct.elem, %struct.elem* %116, i64 0, i32 1
  %118 = load %struct.elem*, %struct.elem** %117, align 8, !tbaa !54
  %119 = getelementptr inbounds %struct.elem, %struct.elem* %118, i64 0, i32 1
  %120 = load %struct.elem*, %struct.elem** %119, align 8, !tbaa !54
  %121 = getelementptr inbounds %struct.elem, %struct.elem* %120, i64 0, i32 1
  %122 = load %struct.elem*, %struct.elem** %121, align 8, !tbaa !54
  %123 = getelementptr inbounds %struct.elem, %struct.elem* %122, i64 0, i32 1
  %124 = load %struct.elem*, %struct.elem** %123, align 8, !tbaa !54
  %125 = getelementptr inbounds %struct.elem, %struct.elem* %124, i64 0, i32 1
  %126 = load %struct.elem*, %struct.elem** %125, align 8, !tbaa !54
  %127 = add nsw i64 %110, 8
  %128 = icmp eq i64 %127, %24
  br i1 %128, label %129, label %108, !prof !96, !llvm.loop !97

129:                                              ; preds = %103, %108, %78, %59
  %130 = phi %struct.elem* [ %61, %59 ], [ %85, %78 ], [ %104, %103 ], [ %126, %108 ]
  %131 = icmp eq %struct.elem* %130, null
  br i1 %131, label %132, label %178, !prof !98

132:                                              ; preds = %129
  %133 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %134 = load %struct.elem*, %struct.elem** %133, align 8, !tbaa !41
  %135 = icmp sgt i64 %6, 2
  br i1 %135, label %136, label %176, !prof !99

136:                                              ; preds = %132, %37
  %137 = phi %struct.elem* [ %39, %37 ], [ %134, %132 ]
  %138 = add i64 %6, -2
  %139 = add i64 %6, -3
  %140 = and i64 %138, 7
  %141 = icmp ult i64 %139, 7
  br i1 %141, label %165, label %142

142:                                              ; preds = %136
  %143 = and i64 %138, -8
  br label %144

144:                                              ; preds = %144, %142
  %145 = phi %struct.elem* [ %137, %142 ], [ %162, %144 ]
  %146 = phi i64 [ %143, %142 ], [ %163, %144 ]
  %147 = getelementptr inbounds %struct.elem, %struct.elem* %145, i64 0, i32 1
  %148 = load %struct.elem*, %struct.elem** %147, align 8, !tbaa !41
  %149 = getelementptr inbounds %struct.elem, %struct.elem* %148, i64 0, i32 1
  %150 = load %struct.elem*, %struct.elem** %149, align 8, !tbaa !41
  %151 = getelementptr inbounds %struct.elem, %struct.elem* %150, i64 0, i32 1
  %152 = load %struct.elem*, %struct.elem** %151, align 8, !tbaa !41
  %153 = getelementptr inbounds %struct.elem, %struct.elem* %152, i64 0, i32 1
  %154 = load %struct.elem*, %struct.elem** %153, align 8, !tbaa !41
  %155 = getelementptr inbounds %struct.elem, %struct.elem* %154, i64 0, i32 1
  %156 = load %struct.elem*, %struct.elem** %155, align 8, !tbaa !41
  %157 = getelementptr inbounds %struct.elem, %struct.elem* %156, i64 0, i32 1
  %158 = load %struct.elem*, %struct.elem** %157, align 8, !tbaa !41
  %159 = getelementptr inbounds %struct.elem, %struct.elem* %158, i64 0, i32 1
  %160 = load %struct.elem*, %struct.elem** %159, align 8, !tbaa !41
  %161 = getelementptr inbounds %struct.elem, %struct.elem* %160, i64 0, i32 1
  %162 = load %struct.elem*, %struct.elem** %161, align 8, !tbaa !41
  %163 = add i64 %146, -8
  %164 = icmp eq i64 %163, 0
  br i1 %164, label %165, label %144, !prof !100, !llvm.loop !101

165:                                              ; preds = %144, %136
  %166 = phi %struct.elem* [ undef, %136 ], [ %162, %144 ]
  %167 = phi %struct.elem* [ %137, %136 ], [ %162, %144 ]
  %168 = icmp eq i64 %140, 0
  br i1 %168, label %176, label %169

169:                                              ; preds = %165, %169
  %170 = phi %struct.elem* [ %173, %169 ], [ %167, %165 ]
  %171 = phi i64 [ %174, %169 ], [ %140, %165 ]
  %172 = getelementptr inbounds %struct.elem, %struct.elem* %170, i64 0, i32 1
  %173 = load %struct.elem*, %struct.elem** %172, align 8, !tbaa !41
  %174 = add i64 %171, -1
  %175 = icmp eq i64 %174, 0
  br i1 %175, label %176, label %169, !prof !102, !llvm.loop !116

176:                                              ; preds = %165, %169, %132
  %177 = phi %struct.elem* [ %134, %132 ], [ %166, %165 ], [ %173, %169 ]
  store %struct.elem* %177, %struct.elem** %3, align 8, !tbaa !41
  br label %178

178:                                              ; preds = %129, %176, %23, %27, %30
  %179 = phi %struct.elem* [ %130, %129 ], [ %177, %176 ], [ undef, %23 ], [ %29, %27 ], [ %32, %30 ]
  %180 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %181 = bitcast %struct.elem** %180 to i8**
  %182 = load i8*, i8** %181, align 8, !tbaa !64
  tail call void @free(i8* %182) #12
  %183 = getelementptr inbounds %struct.elem, %struct.elem* %179, i64 0, i32 1
  store %struct.elem* null, %struct.elem** %183, align 8, !tbaa !54
  store %struct.elem* %179, %struct.elem** %180, align 8, !tbaa !64
  br label %354

184:                                              ; preds = %21
  %185 = icmp sgt i64 %13, 2
  br i1 %185, label %186, label %192, !prof !117

186:                                              ; preds = %184
  %187 = add nsw i64 %13, -2
  %188 = call i32 @_list_get_elem(%struct.llist* nonnull %0, i64 %187, %struct.elem** nonnull %3, i1 zeroext true)
  %189 = load %struct.elem*, %struct.elem** %3, align 8, !tbaa !41
  %190 = getelementptr inbounds %struct.elem, %struct.elem* %189, i64 0, i32 1
  %191 = load %struct.elem*, %struct.elem** %190, align 8, !tbaa !54
  store %struct.elem* %191, %struct.elem** %3, align 8, !tbaa !41
  br label %347

192:                                              ; preds = %184
  %193 = add nsw i64 %13, -1
  switch i64 %13, label %197 [
    i64 1, label %194
    i64 0, label %199
  ], !prof !78

194:                                              ; preds = %192
  %195 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %196 = load %struct.elem*, %struct.elem** %195, align 8, !tbaa !52
  store %struct.elem* %196, %struct.elem** %3, align 8, !tbaa !41
  br label %347

197:                                              ; preds = %192
  %198 = icmp eq i64 %6, %13
  br i1 %198, label %199, label %202, !prof !81

199:                                              ; preds = %197, %192
  %200 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %201 = load %struct.elem*, %struct.elem** %200, align 8, !tbaa !64
  store %struct.elem* %201, %struct.elem** %3, align 8, !tbaa !41
  br label %347

202:                                              ; preds = %197
  %203 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  %204 = load i64, i64* %203, align 8, !tbaa !49
  %205 = icmp eq i64 %204, -1
  br i1 %205, label %206, label %209, !prof !82

206:                                              ; preds = %202
  %207 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %208 = load %struct.elem*, %struct.elem** %207, align 8, !tbaa !41
  br label %305

209:                                              ; preds = %202, %241
  %210 = phi i64 [ %245, %241 ], [ -1, %202 ]
  %211 = phi i64 [ %244, %241 ], [ 0, %202 ]
  %212 = phi i64 [ %243, %241 ], [ 0, %202 ]
  %213 = phi i64 [ %242, %241 ], [ %204, %202 ]
  %214 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %213
  %215 = load i64, i64* %214, align 8, !tbaa !67
  switch i64 %215, label %226 [
    i64 -1, label %216
    i64 -2, label %221
  ], !prof !83

216:                                              ; preds = %209
  %217 = icmp eq i64 %213, 0
  br i1 %217, label %247, label %218, !prof !84

218:                                              ; preds = %216
  %219 = add nsw i64 %212, 511
  %220 = sub i64 %219, %213
  br label %241

221:                                              ; preds = %209
  %222 = icmp eq i64 %213, 511
  %223 = add nsw i64 %213, 1
  %224 = select i1 %222, i64 0, i64 %223, !prof !85
  %225 = add nsw i64 %212, 1
  br label %241

226:                                              ; preds = %209
  %227 = icmp eq i64 %215, %193
  br i1 %227, label %228, label %231, !prof !86

228:                                              ; preds = %226
  %229 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %213
  %230 = load %struct.elem*, %struct.elem** %229, align 8, !tbaa !41
  br label %298

231:                                              ; preds = %226
  %232 = icmp slt i64 %215, %193
  %233 = icmp sgt i64 %215, %211
  %234 = and i1 %232, %233
  %235 = select i1 %234, i64 %215, i64 %211, !prof !87
  %236 = select i1 %234, i64 %213, i64 %210, !prof !87
  %237 = icmp eq i64 %213, 511
  %238 = add nsw i64 %213, 1
  %239 = select i1 %237, i64 0, i64 %238, !prof !88
  %240 = add nsw i64 %212, 1
  br label %241

241:                                              ; preds = %231, %221, %218
  %242 = phi i64 [ 0, %218 ], [ %224, %221 ], [ %239, %231 ]
  %243 = phi i64 [ %220, %218 ], [ %225, %221 ], [ %240, %231 ]
  %244 = phi i64 [ %211, %218 ], [ %211, %221 ], [ %235, %231 ]
  %245 = phi i64 [ %210, %218 ], [ %210, %221 ], [ %236, %231 ]
  %246 = icmp slt i64 %243, 512
  br i1 %246, label %209, label %247, !prof !89, !llvm.loop !90

247:                                              ; preds = %241, %216
  %248 = phi i64 [ %245, %241 ], [ %210, %216 ]
  %249 = phi i64 [ %244, %241 ], [ %211, %216 ]
  %250 = icmp sgt i64 %248, -1
  %251 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %252 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %248
  %253 = select i1 %250, %struct.elem** %252, %struct.elem** %251, !prof !91
  %254 = load %struct.elem*, %struct.elem** %253, align 8, !tbaa !41
  %255 = icmp slt i64 %249, %193
  br i1 %255, label %256, label %298, !prof !92

256:                                              ; preds = %247
  %257 = xor i64 %249, -1
  %258 = add i64 %13, %257
  %259 = add i64 %13, -2
  %260 = sub i64 %259, %249
  %261 = and i64 %258, 7
  %262 = icmp eq i64 %261, 0
  br i1 %262, label %272, label %263

263:                                              ; preds = %256, %263
  %264 = phi %struct.elem* [ %268, %263 ], [ %254, %256 ]
  %265 = phi i64 [ %269, %263 ], [ %249, %256 ]
  %266 = phi i64 [ %270, %263 ], [ %261, %256 ]
  %267 = getelementptr inbounds %struct.elem, %struct.elem* %264, i64 0, i32 1
  %268 = load %struct.elem*, %struct.elem** %267, align 8, !tbaa !54
  %269 = add nsw i64 %265, 1
  %270 = add i64 %266, -1
  %271 = icmp eq i64 %270, 0
  br i1 %271, label %272, label %263, !prof !93, !llvm.loop !118

272:                                              ; preds = %263, %256
  %273 = phi %struct.elem* [ undef, %256 ], [ %268, %263 ]
  %274 = phi %struct.elem* [ %254, %256 ], [ %268, %263 ]
  %275 = phi i64 [ %249, %256 ], [ %269, %263 ]
  %276 = icmp ult i64 %260, 7
  br i1 %276, label %298, label %277

277:                                              ; preds = %272, %277
  %278 = phi %struct.elem* [ %295, %277 ], [ %274, %272 ]
  %279 = phi i64 [ %296, %277 ], [ %275, %272 ]
  %280 = getelementptr inbounds %struct.elem, %struct.elem* %278, i64 0, i32 1
  %281 = load %struct.elem*, %struct.elem** %280, align 8, !tbaa !54
  %282 = getelementptr inbounds %struct.elem, %struct.elem* %281, i64 0, i32 1
  %283 = load %struct.elem*, %struct.elem** %282, align 8, !tbaa !54
  %284 = getelementptr inbounds %struct.elem, %struct.elem* %283, i64 0, i32 1
  %285 = load %struct.elem*, %struct.elem** %284, align 8, !tbaa !54
  %286 = getelementptr inbounds %struct.elem, %struct.elem* %285, i64 0, i32 1
  %287 = load %struct.elem*, %struct.elem** %286, align 8, !tbaa !54
  %288 = getelementptr inbounds %struct.elem, %struct.elem* %287, i64 0, i32 1
  %289 = load %struct.elem*, %struct.elem** %288, align 8, !tbaa !54
  %290 = getelementptr inbounds %struct.elem, %struct.elem* %289, i64 0, i32 1
  %291 = load %struct.elem*, %struct.elem** %290, align 8, !tbaa !54
  %292 = getelementptr inbounds %struct.elem, %struct.elem* %291, i64 0, i32 1
  %293 = load %struct.elem*, %struct.elem** %292, align 8, !tbaa !54
  %294 = getelementptr inbounds %struct.elem, %struct.elem* %293, i64 0, i32 1
  %295 = load %struct.elem*, %struct.elem** %294, align 8, !tbaa !54
  %296 = add nsw i64 %279, 8
  %297 = icmp eq i64 %296, %193
  br i1 %297, label %298, label %277, !prof !96, !llvm.loop !97

298:                                              ; preds = %272, %277, %247, %228
  %299 = phi %struct.elem* [ %230, %228 ], [ %254, %247 ], [ %273, %272 ], [ %295, %277 ]
  %300 = icmp eq %struct.elem* %299, null
  br i1 %300, label %301, label %347, !prof !98

301:                                              ; preds = %298
  %302 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %303 = load %struct.elem*, %struct.elem** %302, align 8, !tbaa !41
  %304 = icmp sgt i64 %13, 1
  br i1 %304, label %305, label %345, !prof !99

305:                                              ; preds = %301, %206
  %306 = phi %struct.elem* [ %208, %206 ], [ %303, %301 ]
  %307 = add i64 %13, -1
  %308 = add i64 %13, -2
  %309 = and i64 %307, 7
  %310 = icmp ult i64 %308, 7
  br i1 %310, label %334, label %311

311:                                              ; preds = %305
  %312 = and i64 %307, -8
  br label %313

313:                                              ; preds = %313, %311
  %314 = phi %struct.elem* [ %306, %311 ], [ %331, %313 ]
  %315 = phi i64 [ %312, %311 ], [ %332, %313 ]
  %316 = getelementptr inbounds %struct.elem, %struct.elem* %314, i64 0, i32 1
  %317 = load %struct.elem*, %struct.elem** %316, align 8, !tbaa !41
  %318 = getelementptr inbounds %struct.elem, %struct.elem* %317, i64 0, i32 1
  %319 = load %struct.elem*, %struct.elem** %318, align 8, !tbaa !41
  %320 = getelementptr inbounds %struct.elem, %struct.elem* %319, i64 0, i32 1
  %321 = load %struct.elem*, %struct.elem** %320, align 8, !tbaa !41
  %322 = getelementptr inbounds %struct.elem, %struct.elem* %321, i64 0, i32 1
  %323 = load %struct.elem*, %struct.elem** %322, align 8, !tbaa !41
  %324 = getelementptr inbounds %struct.elem, %struct.elem* %323, i64 0, i32 1
  %325 = load %struct.elem*, %struct.elem** %324, align 8, !tbaa !41
  %326 = getelementptr inbounds %struct.elem, %struct.elem* %325, i64 0, i32 1
  %327 = load %struct.elem*, %struct.elem** %326, align 8, !tbaa !41
  %328 = getelementptr inbounds %struct.elem, %struct.elem* %327, i64 0, i32 1
  %329 = load %struct.elem*, %struct.elem** %328, align 8, !tbaa !41
  %330 = getelementptr inbounds %struct.elem, %struct.elem* %329, i64 0, i32 1
  %331 = load %struct.elem*, %struct.elem** %330, align 8, !tbaa !41
  %332 = add i64 %315, -8
  %333 = icmp eq i64 %332, 0
  br i1 %333, label %334, label %313, !prof !100, !llvm.loop !101

334:                                              ; preds = %313, %305
  %335 = phi %struct.elem* [ undef, %305 ], [ %331, %313 ]
  %336 = phi %struct.elem* [ %306, %305 ], [ %331, %313 ]
  %337 = icmp eq i64 %309, 0
  br i1 %337, label %345, label %338

338:                                              ; preds = %334, %338
  %339 = phi %struct.elem* [ %342, %338 ], [ %336, %334 ]
  %340 = phi i64 [ %343, %338 ], [ %309, %334 ]
  %341 = getelementptr inbounds %struct.elem, %struct.elem* %339, i64 0, i32 1
  %342 = load %struct.elem*, %struct.elem** %341, align 8, !tbaa !41
  %343 = add i64 %340, -1
  %344 = icmp eq i64 %343, 0
  br i1 %344, label %345, label %338, !prof !102, !llvm.loop !119

345:                                              ; preds = %334, %338, %301
  %346 = phi %struct.elem* [ %303, %301 ], [ %335, %334 ], [ %342, %338 ]
  store %struct.elem* %346, %struct.elem** %3, align 8, !tbaa !41
  br label %347

347:                                              ; preds = %298, %345, %199, %194, %186
  %348 = phi %struct.elem* [ %299, %298 ], [ %346, %345 ], [ %201, %199 ], [ %196, %194 ], [ %191, %186 ]
  %349 = getelementptr inbounds %struct.elem, %struct.elem* %348, i64 0, i32 1
  %350 = load %struct.elem*, %struct.elem** %349, align 8, !tbaa !54
  %351 = getelementptr inbounds %struct.elem, %struct.elem* %350, i64 0, i32 1
  %352 = load %struct.elem*, %struct.elem** %351, align 8, !tbaa !54
  store %struct.elem* %352, %struct.elem** %349, align 8, !tbaa !54
  %353 = bitcast %struct.elem* %350 to i8*
  tail call void @free(i8* %353) #12
  br label %354

354:                                              ; preds = %178, %347, %15
  %355 = load i64, i64* %5, align 8, !tbaa !58
  %356 = add nsw i64 %355, -1
  store i64 %356, i64* %5, align 8, !tbaa !58
  br label %357

357:                                              ; preds = %380, %354
  %358 = phi i64 [ 0, %354 ], [ %381, %380 ]
  %359 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %358
  %360 = load i64, i64* %359, align 8, !tbaa !67
  %361 = icmp eq i64 %360, 1
  br i1 %361, label %366, label %362, !prof !120

362:                                              ; preds = %357
  %363 = icmp slt i64 %360, %13
  br i1 %363, label %368, label %364, !prof !121

364:                                              ; preds = %362
  %365 = add nsw i64 %360, -1
  br label %366

366:                                              ; preds = %357, %364
  %367 = phi i64 [ %365, %364 ], [ -2, %357 ]
  store i64 %367, i64* %359, align 8, !tbaa !67
  br label %368

368:                                              ; preds = %366, %362
  %369 = or i64 %358, 1
  %370 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %369
  %371 = load i64, i64* %370, align 8, !tbaa !67
  %372 = icmp eq i64 %371, 1
  br i1 %372, label %378, label %374, !prof !120

373:                                              ; preds = %380, %2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4) #12
  ret void

374:                                              ; preds = %368
  %375 = icmp slt i64 %371, %13
  br i1 %375, label %380, label %376, !prof !121

376:                                              ; preds = %374
  %377 = add nsw i64 %371, -1
  br label %378

378:                                              ; preds = %376, %368
  %379 = phi i64 [ %377, %376 ], [ -2, %368 ]
  store i64 %379, i64* %370, align 8, !tbaa !67
  br label %380

380:                                              ; preds = %378, %374
  %381 = add nuw nsw i64 %358, 2
  %382 = icmp eq i64 %381, 512
  br i1 %382, label %373, label %357, !prof !122, !llvm.loop !123
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @list_show(%struct.llist* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([7 x i8], [7 x i8]* @str, i64 0, i64 0))
  %3 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 0
  %4 = load i64, i64* %3, align 8, !tbaa !58
  %5 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1, i64 0, i64 0), i64 %4)
  %6 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 1
  %7 = load %struct.elem*, %struct.elem** %6, align 8, !tbaa !52
  %8 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([14 x i8], [14 x i8]* @.str.2, i64 0, i64 0), %struct.elem* %7)
  %9 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 2
  %10 = load %struct.elem*, %struct.elem** %9, align 8, !tbaa !64
  %11 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i64 0, i64 0), %struct.elem* %10)
  %12 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @str.11, i64 0, i64 0))
  %13 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0))
  br label %14

14:                                               ; preds = %1, %14
  %15 = phi i64 [ 0, %1 ], [ %19, %14 ]
  %16 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 3, i64 %15
  %17 = load i64, i64* %16, align 8, !tbaa !67
  %18 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0), i64 %17)
  %19 = add nuw nsw i64 %15, 1
  %20 = icmp eq i64 %19, 512
  br i1 %20, label %21, label %14, !llvm.loop !124

21:                                               ; preds = %14
  %22 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.7, i64 0, i64 0))
  br label %23

23:                                               ; preds = %21, %23
  %24 = phi i64 [ 0, %21 ], [ %28, %23 ]
  %25 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 4, i64 %24
  %26 = load %struct.elem*, %struct.elem** %25, align 8, !tbaa !41
  %27 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @.str.8, i64 0, i64 0), %struct.elem* %26)
  %28 = add nuw nsw i64 %24, 1
  %29 = icmp eq i64 %28, 512
  br i1 %29, label %30, label %23, !llvm.loop !125

30:                                               ; preds = %23
  %31 = getelementptr inbounds %struct.llist, %struct.llist* %0, i64 0, i32 5
  %32 = load i64, i64* %31, align 8, !tbaa !49
  %33 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @.str.9, i64 0, i64 0), i64 %32)
  %34 = tail call i32 @putchar(i32 10)
  ret void
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i32 @puts(i8* nocapture noundef readonly) local_unnamed_addr #10

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #10

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #11

attributes #0 = { nofree norecurse nounwind uwtable writeonly "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { inaccessiblemem_or_argmemonly nounwind willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { norecurse nounwind readonly uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { inaccessiblememonly nofree nounwind willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nofree norecurse nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nofree norecurse nounwind uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nofree nounwind }
attributes #11 = { argmemonly nofree nosync nounwind willreturn writeonly }
attributes #12 = { nounwind }

!llvm.module.flags = !{!0, !29, !30}
!llvm.ident = !{!39}

!0 = !{i32 1, !"ProfileSummary", !1}
!1 = !{!2, !3, !4, !5, !6, !7, !8, !9, !10, !11}
!2 = !{!"ProfileFormat", !"InstrProf"}
!3 = !{!"TotalCount", i64 886731805}
!4 = !{!"MaxCount", i64 511873536}
!5 = !{!"MaxInternalCount", i64 511873536}
!6 = !{!"MaxFunctionCount", i64 7999645}
!7 = !{!"NumCounts", i64 67}
!8 = !{!"NumFunctions", i64 18}
!9 = !{!"IsPartialProfile", i64 0}
!10 = !{!"PartialProfileRatio", double 0.000000e+00}
!11 = !{!"DetailedSummary", !12}
!12 = !{!13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28}
!13 = !{i32 10000, i64 511873536, i32 1}
!14 = !{i32 100000, i64 511873536, i32 1}
!15 = !{i32 200000, i64 511873536, i32 1}
!16 = !{i32 300000, i64 511873536, i32 1}
!17 = !{i32 400000, i64 511873536, i32 1}
!18 = !{i32 500000, i64 511873536, i32 1}
!19 = !{i32 600000, i64 255804078, i32 2}
!20 = !{i32 700000, i64 255804078, i32 2}
!21 = !{i32 800000, i64 255804078, i32 2}
!22 = !{i32 900000, i64 7999348, i32 6}
!23 = !{i32 950000, i64 6000000, i32 12}
!24 = !{i32 990000, i64 4000000, i32 20}
!25 = !{i32 999000, i64 921197, i32 26}
!26 = !{i32 999900, i64 59392, i32 27}
!27 = !{i32 999990, i64 15600, i32 30}
!28 = !{i32 999999, i64 297, i32 34}
!29 = !{i32 1, !"wchar_size", i32 4}
!30 = !{i32 5, !"CG Profile", !31}
!31 = !{!32, !33, !34, !35, !36, !37, !38}
!32 = !{void (%struct.llist*)* @list_destroy, void (i8*)* @free, i64 688}
!33 = !{void (%struct.llist*, i64, i8*)* @list_insert_i, i8* (i64)* @malloc, i64 4999998}
!34 = !{void (%struct.llist*, i64, i8*)* @list_insert_i, i32 (%struct.llist*, i64, %struct.elem**, i1)* @_list_get_elem, i64 999752}
!35 = !{void (%struct.llist*, i64, i8**)* @list_get_i, i32 (%struct.llist*, i64, %struct.elem**, i1)* @_list_get_elem, i64 6000000}
!36 = !{i32 (%struct.llist*, i64, i8*, i8**)* @list_set_i, i32 (%struct.llist*, i64, %struct.elem**, i1)* @_list_get_elem, i64 0}
!37 = !{void (%struct.llist*, i64)* @list_rem_i, void (i8*)* @free, i64 999998}
!38 = !{void (%struct.llist*, i64)* @list_rem_i, i32 (%struct.llist*, i64, %struct.elem**, i1)* @_list_get_elem, i64 999463}
!39 = !{!"clang version 12.0.1"}
!40 = !{!"function_entry_count", i64 50}
!41 = !{!42, !42, i64 0}
!42 = !{!"any pointer", !43, i64 0}
!43 = !{!"omnipotent char", !44, i64 0}
!44 = !{!"Simple C/C++ TBAA"}
!45 = !{!"branch_weights", i32 51, i32 6324}
!46 = distinct !{!46, !47, !48}
!47 = !{!"llvm.loop.mustprogress"}
!48 = !{!"llvm.loop.isvectorized", i32 1}
!49 = !{!50, !51, i64 8216}
!50 = !{!"llist", !51, i64 0, !42, i64 8, !42, i64 16, !43, i64 24, !43, i64 4120, !51, i64 8216}
!51 = !{!"long", !43, i64 0}
!52 = !{!50, !42, i64 8}
!53 = !{!"branch_weights", i32 51, i32 651}
!54 = !{!55, !42, i64 8}
!55 = !{!"elem", !42, i64 0, !42, i64 8}
!56 = distinct !{!56, !47}
!57 = !{!"function_entry_count", i64 0}
!58 = !{!50, !51, i64 0}
!59 = !{!"function_entry_count", i64 5000000}
!60 = !{!"branch_weights", i32 1, i32 5000001}
!61 = !{!55, !42, i64 0}
!62 = !{!"branch_weights", i32 -1853543348, i32 610256349}
!63 = !{!"branch_weights", i32 51, i32 4000082}
!64 = !{!50, !42, i64 16}
!65 = !{!"branch_weights", i32 117, i32 999754}
!66 = !{!"branch_weights", i32 1, i32 117}
!67 = !{!51, !51, i64 0}
!68 = !{!"branch_weights", i32 1, i32 59393}
!69 = !{!"branch_weights", i32 32453, i32 26941}
!70 = !{!"branch_weights", i32 3, i32 511873535}
!71 = !{!"branch_weights", i32 256069457, i32 255804079}
!72 = !{!"branch_weights", i32 117, i32 59393}
!73 = distinct !{!73, !47}
!74 = !{!"branch_weights", i32 999754, i32 511873537}
!75 = distinct !{!75, !47}
!76 = !{!"function_entry_count", i64 7999645}
!77 = !{!"branch_weights", i32 976, i32 -389062992}
!78 = !{!"branch_weights", i32 -389353013, i32 145495, i32 488}
!79 = !{!"branch_weights", i32 172, i32 127}
!80 = !{!"branch_weights", i32 15601, i32 7983389}
!81 = !{!"branch_weights", i32 67, i32 7999283}
!82 = !{!"branch_weights", i32 7999283, i32 1521368095}
!83 = !{!"branch_weights", i32 -2139432426, i32 21655, i32 24620}
!84 = !{!"branch_weights", i32 1, i32 15284}
!85 = !{!"branch_weights", i32 17, i32 17361}
!86 = !{!"branch_weights", i32 5058452, i32 1516276985}
!87 = !{!"branch_weights", i32 48878839, i32 -62004579}
!88 = !{!"branch_weights", i32 2954415, i32 1513322571}
!89 = !{!"branch_weights", i32 2143376640, i32 4107008}
!90 = distinct !{!90, !47}
!91 = !{!"branch_weights", i32 2934624, i32 6177}
!92 = !{!"branch_weights", i32 396340395, i32 2940800}
!93 = !{!"branch_weights", i32 2940800, i32 20585600}
!94 = distinct !{!94, !95}
!95 = !{!"llvm.loop.unroll.disable"}
!96 = !{!"branch_weights", i32 2940800, i32 396340395}
!97 = distinct !{!97, !47}
!98 = !{!"branch_weights", i32 0, i32 -2147483648}
!99 = !{!"branch_weights", i32 1073741824, i32 1073741824}
!100 = !{!"branch_weights", i32 33, i32 921198}
!101 = distinct !{!101, !47}
!102 = !{!"branch_weights", i32 33, i32 231}
!103 = distinct !{!103, !95}
!104 = !{!"branch_weights", i32 -389789977, i32 227998}
!105 = !{!"function_entry_count", i64 6000000}
!106 = !{!"branch_weights", i32 6000001, i32 1}
!107 = !{!"function_entry_count", i64 7998988}
!108 = !{!"function_entry_count", i64 7999282}
!109 = distinct !{!109, !95}
!110 = !{!"function_entry_count", i64 1000117}
!111 = !{!"branch_weights", i32 464844, i32 -388709484}
!112 = !{!"branch_weights", i32 108, i32 999894}
!113 = !{!"branch_weights", i32 109, i32 999893}
!114 = !{!"branch_weights", i32 205, i32 999689}
!115 = distinct !{!115, !95}
!116 = distinct !{!116, !95}
!117 = !{!"branch_weights", i32 999469, i32 221}
!118 = distinct !{!118, !95}
!119 = distinct !{!119, !95}
!120 = !{!"branch_weights", i32 5209, i32 511994793}
!121 = !{!"branch_weights", i32 257114129, i32 254880665}
!122 = !{!"branch_weights", i32 1000001, i32 512000001}
!123 = distinct !{!123, !47}
!124 = distinct !{!124, !47}
!125 = distinct !{!125, !47}
