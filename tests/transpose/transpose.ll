; ModuleID = './transpose/transpose.bc'
source_filename = "parallel_bc"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

; Function Attrs: alwaysinline nofree norecurse nosync nounwind memory(argmem: readwrite)
define void @_pocl_kernel_transpose(ptr nocapture noundef writeonly align 4 %0, ptr nocapture noundef readonly align 4 %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, ptr nocapture noundef align 4 %5, ptr nocapture readonly %6, i32 %7, i32 %8, i32 %9) local_unnamed_addr #0 !kernel_arg_addr_space !28 !kernel_arg_access_qual !29 !kernel_arg_type !30 !kernel_arg_base_type !30 !kernel_arg_type_qual !31 !kernel_arg_name !32 !pocl_generated !33 {
  %11 = getelementptr inbounds { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %6, i32 0, i32 2
  %12 = load i32, ptr %11, align 4
  %13 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %6, i32 0, i32 2, i32 1
  %14 = load i32, ptr %13, align 4
  %15 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %6, i32 0, i32 2, i32 2
  %16 = load i32, ptr %15, align 4
  %17 = mul i32 %12, %7
  %18 = mul i32 %14, %8
  %19 = add i32 %17, %2
  %umax9 = call i32 @llvm.umax.i32(i32 %12, i32 1)
  %umax11 = call i32 @llvm.umax.i32(i32 %14, i32 1)
  %umax13 = call i32 @llvm.umax.i32(i32 %16, i32 1)
  br label %pregion_for_entry.pregion_for_init12.i

pregion_for_entry.pregion_for_init12.i:           ; preds = %pregion_for_end13.i, %10
  %_local_id_z.0 = phi i32 [ 0, %10 ], [ %22, %pregion_for_end13.i ]
  br label %pregion_for_entry.pregion_for_init8.i

pregion_for_entry.pregion_for_init8.i:            ; preds = %pregion_for_end9.i, %pregion_for_entry.pregion_for_init12.i
  %_local_id_y.0 = phi i32 [ 0, %pregion_for_entry.pregion_for_init12.i ], [ %23, %pregion_for_end9.i ]
  %20 = add i32 %_local_id_y.0, %18
  %.fr = freeze i32 %20
  %cmp2.i = icmp ult i32 %.fr, %4
  %mul.i = mul i32 %.fr, %3
  %mul6.i = mul i32 %_local_id_y.0, 17
  br i1 %cmp2.i, label %pregion_for_entry.entry.i.preheader, label %pregion_for_end9.i

pregion_for_entry.entry.i.preheader:              ; preds = %pregion_for_entry.pregion_for_init8.i
  br label %pregion_for_entry.entry.i

pregion_for_entry.entry.i:                        ; preds = %if.end.r_exit.i, %pregion_for_entry.entry.i.preheader
  %_local_id_x.0 = phi i32 [ %24, %if.end.r_exit.i ], [ 0, %pregion_for_entry.entry.i.preheader ]
  %add.i = add i32 %19, %_local_id_x.0
  %cmp.i = icmp ult i32 %add.i, %3
  br i1 %cmp.i, label %if.then.i, label %if.end.r_exit.i

if.then.i:                                        ; preds = %pregion_for_entry.entry.i
  %add4.i = add i32 %add.i, %mul.i
  %arrayidx.i = getelementptr inbounds float, ptr %1, i32 %add4.i
  %21 = load float, ptr %arrayidx.i, align 4, !tbaa !34, !llvm.access.group !38
  %add8.i = add i32 %_local_id_x.0, %mul6.i
  %arrayidx9.i = getelementptr inbounds float, ptr %5, i32 %add8.i
  store float %21, ptr %arrayidx9.i, align 4, !tbaa !34, !llvm.access.group !38
  br label %if.end.r_exit.i

pregion_for_end13.i:                              ; preds = %pregion_for_end9.i
  %22 = add nuw i32 %_local_id_z.0, 1
  %exitcond14.not = icmp eq i32 %22, %umax13
  br i1 %exitcond14.not, label %pregion_for_entry.pregion_for_init4.i.preheader, label %pregion_for_entry.pregion_for_init12.i, !llvm.loop !42

pregion_for_entry.pregion_for_init4.i.preheader:  ; preds = %pregion_for_end13.i
  %mul11.i = shl i32 %8, 4
  %mul15.i = shl i32 %7, 4
  br label %pregion_for_entry.pregion_for_init4.i

pregion_for_end9.i.loopexit:                      ; preds = %if.end.r_exit.i
  br label %pregion_for_end9.i

pregion_for_end9.i:                               ; preds = %pregion_for_end9.i.loopexit, %pregion_for_entry.pregion_for_init8.i
  %23 = add nuw i32 %_local_id_y.0, 1
  %exitcond12.not = icmp eq i32 %23, %umax11
  br i1 %exitcond12.not, label %pregion_for_end13.i, label %pregion_for_entry.pregion_for_init8.i, !llvm.loop !44

if.end.r_exit.i:                                  ; preds = %if.then.i, %pregion_for_entry.entry.i
  %24 = add nuw i32 %_local_id_x.0, 1
  %exitcond10.not = icmp eq i32 %24, %umax9
  br i1 %exitcond10.not, label %pregion_for_end9.i.loopexit, label %pregion_for_entry.entry.i, !llvm.loop !46

pregion_for_entry.pregion_for_init4.i:            ; preds = %pregion_for_end1.i, %pregion_for_entry.pregion_for_init4.i.preheader
  %_local_id_z.1 = phi i32 [ %27, %pregion_for_end1.i ], [ 0, %pregion_for_entry.pregion_for_init4.i.preheader ]
  br label %pregion_for_entry.pregion_for_init.i

pregion_for_entry.pregion_for_init.i:             ; preds = %pregion_for_end.i, %pregion_for_entry.pregion_for_init4.i
  %_local_id_y.1 = phi i32 [ 0, %pregion_for_entry.pregion_for_init4.i ], [ %28, %pregion_for_end.i ]
  %add17.i = add i32 %_local_id_y.1, %mul15.i
  %add17.i.fr = freeze i32 %add17.i
  %add20.i = add i32 %add17.i.fr, %2
  %cmp21.i = icmp ult i32 %add20.i, %3
  %mul23.i = mul i32 %add17.i.fr, %4
  br i1 %cmp21.i, label %pregion_for_entry.if.end.postbarrier.i.preheader, label %pregion_for_end.i

pregion_for_entry.if.end.postbarrier.i.preheader: ; preds = %pregion_for_entry.pregion_for_init.i
  br label %pregion_for_entry.if.end.postbarrier.i

pregion_for_entry.if.end.postbarrier.i:           ; preds = %if.end31.r_exit.i, %pregion_for_entry.if.end.postbarrier.i.preheader
  %_local_id_x.1 = phi i32 [ %26, %if.end31.r_exit.i ], [ 0, %pregion_for_entry.if.end.postbarrier.i.preheader ]
  %add13.i = add i32 %_local_id_x.1, %mul11.i
  %cmp18.i = icmp ult i32 %add13.i, %4
  br i1 %cmp18.i, label %if.then22.i, label %if.end31.r_exit.i

if.then22.i:                                      ; preds = %pregion_for_entry.if.end.postbarrier.i
  %add24.i = add i32 %add13.i, %mul23.i
  %arrayidx30.i = getelementptr inbounds float, ptr %0, i32 %add24.i
  %mul26.i = mul i32 %_local_id_x.1, 17
  %add28.i = add i32 %mul26.i, %_local_id_y.1
  %arrayidx29.i = getelementptr inbounds float, ptr %5, i32 %add28.i
  %25 = load float, ptr %arrayidx29.i, align 4, !tbaa !34, !llvm.access.group !48
  store float %25, ptr %arrayidx30.i, align 4, !tbaa !34, !llvm.access.group !48
  br label %if.end31.r_exit.i

if.end31.r_exit.i:                                ; preds = %if.then22.i, %pregion_for_entry.if.end.postbarrier.i
  %26 = add nuw i32 %_local_id_x.1, 1
  %exitcond.not = icmp eq i32 %26, %umax9
  br i1 %exitcond.not, label %pregion_for_end.i.loopexit, label %pregion_for_entry.if.end.postbarrier.i, !llvm.loop !52

pregion_for_end1.i:                               ; preds = %pregion_for_end.i
  %27 = add nuw i32 %_local_id_z.1, 1
  %exitcond8.not = icmp eq i32 %27, %umax13
  br i1 %exitcond8.not, label %transpose.exit, label %pregion_for_entry.pregion_for_init4.i, !llvm.loop !54

pregion_for_end.i.loopexit:                       ; preds = %if.end31.r_exit.i
  br label %pregion_for_end.i

pregion_for_end.i:                                ; preds = %pregion_for_end.i.loopexit, %pregion_for_entry.pregion_for_init.i
  %28 = add nuw i32 %_local_id_y.1, 1
  %exitcond6.not = icmp eq i32 %28, %umax11
  br i1 %exitcond6.not, label %pregion_for_end1.i, label %pregion_for_entry.pregion_for_init.i, !llvm.loop !56

transpose.exit:                                   ; preds = %pregion_for_end1.i
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none)
define void @_pocl_kernel_transpose_workgroup(ptr nocapture readonly %0, ptr nocapture readonly %1, i32 %2, i32 %3, i32 %4) local_unnamed_addr #1 {
  %6 = load ptr, ptr %0, align 4
  %7 = load ptr, ptr %6, align 4
  %8 = getelementptr ptr, ptr %0, i32 1
  %9 = load ptr, ptr %8, align 4
  %10 = load ptr, ptr %9, align 4
  %11 = getelementptr ptr, ptr %0, i32 2
  %12 = load ptr, ptr %11, align 4
  %13 = load i32, ptr %12, align 4
  %14 = getelementptr ptr, ptr %0, i32 3
  %15 = load ptr, ptr %14, align 4
  %16 = load i32, ptr %15, align 4
  %17 = getelementptr ptr, ptr %0, i32 4
  %18 = load ptr, ptr %17, align 4
  %19 = load i32, ptr %18, align 4
  %20 = getelementptr ptr, ptr %0, i32 5
  %21 = load ptr, ptr %20, align 4
  %22 = load ptr, ptr %21, align 4
  %23 = getelementptr inbounds { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %1, i32 0, i32 2
  %24 = load i32, ptr %23, align 4
  %25 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %1, i32 0, i32 2, i32 1
  %26 = load i32, ptr %25, align 4
  %27 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %1, i32 0, i32 2, i32 2
  %28 = load i32, ptr %27, align 4
  %29 = mul i32 %24, %2
  %30 = mul i32 %26, %3
  %31 = add i32 %29, %13
  %umax9 = call i32 @llvm.umax.i32(i32 %24, i32 1)
  %umax11 = call i32 @llvm.umax.i32(i32 %26, i32 1)
  %umax13 = call i32 @llvm.umax.i32(i32 %28, i32 1)
  br label %pregion_for_entry.pregion_for_init12.i.i

pregion_for_entry.pregion_for_init12.i.i:         ; preds = %pregion_for_end13.i.i, %5
  %_local_id_z.i.0 = phi i32 [ 0, %5 ], [ %34, %pregion_for_end13.i.i ]
  br label %pregion_for_entry.pregion_for_init8.i.i

pregion_for_entry.pregion_for_init8.i.i:          ; preds = %pregion_for_end9.i.i, %pregion_for_entry.pregion_for_init12.i.i
  %_local_id_y.i.0 = phi i32 [ 0, %pregion_for_entry.pregion_for_init12.i.i ], [ %35, %pregion_for_end9.i.i ]
  %32 = add i32 %_local_id_y.i.0, %30
  %cmp2.i.i = icmp ult i32 %32, %19
  %mul.i.i = mul i32 %32, %16
  %mul6.i.i = mul i32 %_local_id_y.i.0, 17
  %cmp2.i.i.fr = freeze i1 %cmp2.i.i
  br i1 %cmp2.i.i.fr, label %pregion_for_entry.entry.i.i.preheader, label %pregion_for_end9.i.i

pregion_for_entry.entry.i.i.preheader:            ; preds = %pregion_for_entry.pregion_for_init8.i.i
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %if.end.r_exit.i.i, %pregion_for_entry.entry.i.i.preheader
  %_local_id_x.i.0 = phi i32 [ %36, %if.end.r_exit.i.i ], [ 0, %pregion_for_entry.entry.i.i.preheader ]
  %add.i.i = add i32 %31, %_local_id_x.i.0
  %cmp.i.i = icmp ult i32 %add.i.i, %16
  br i1 %cmp.i.i, label %if.then.i.i, label %if.end.r_exit.i.i

if.then.i.i:                                      ; preds = %pregion_for_entry.entry.i.i
  %add4.i.i = add i32 %add.i.i, %mul.i.i
  %arrayidx.i.i = getelementptr inbounds float, ptr %10, i32 %add4.i.i
  %33 = load float, ptr %arrayidx.i.i, align 4, !tbaa !34, !llvm.access.group !38
  %add8.i.i = add i32 %_local_id_x.i.0, %mul6.i.i
  %arrayidx9.i.i = getelementptr inbounds float, ptr %22, i32 %add8.i.i
  store float %33, ptr %arrayidx9.i.i, align 4, !tbaa !34, !llvm.access.group !38
  br label %if.end.r_exit.i.i

pregion_for_end13.i.i:                            ; preds = %pregion_for_end9.i.i
  %34 = add nuw i32 %_local_id_z.i.0, 1
  %exitcond14.not = icmp eq i32 %34, %umax13
  br i1 %exitcond14.not, label %pregion_for_entry.pregion_for_init4.i.i.preheader, label %pregion_for_entry.pregion_for_init12.i.i, !llvm.loop !42

pregion_for_entry.pregion_for_init4.i.i.preheader: ; preds = %pregion_for_end13.i.i
  %mul11.i.i = shl i32 %3, 4
  %mul15.i.i = shl i32 %2, 4
  br label %pregion_for_entry.pregion_for_init4.i.i

pregion_for_end9.i.i.loopexit:                    ; preds = %if.end.r_exit.i.i
  br label %pregion_for_end9.i.i

pregion_for_end9.i.i:                             ; preds = %pregion_for_end9.i.i.loopexit, %pregion_for_entry.pregion_for_init8.i.i
  %35 = add nuw i32 %_local_id_y.i.0, 1
  %exitcond12.not = icmp eq i32 %35, %umax11
  br i1 %exitcond12.not, label %pregion_for_end13.i.i, label %pregion_for_entry.pregion_for_init8.i.i, !llvm.loop !44

if.end.r_exit.i.i:                                ; preds = %if.then.i.i, %pregion_for_entry.entry.i.i
  %36 = add nuw i32 %_local_id_x.i.0, 1
  %exitcond10.not = icmp eq i32 %36, %umax9
  br i1 %exitcond10.not, label %pregion_for_end9.i.i.loopexit, label %pregion_for_entry.entry.i.i, !llvm.loop !46

pregion_for_entry.pregion_for_init4.i.i:          ; preds = %pregion_for_end1.i.i, %pregion_for_entry.pregion_for_init4.i.i.preheader
  %_local_id_z.i.1 = phi i32 [ %39, %pregion_for_end1.i.i ], [ 0, %pregion_for_entry.pregion_for_init4.i.i.preheader ]
  br label %pregion_for_entry.pregion_for_init.i.i

pregion_for_entry.pregion_for_init.i.i:           ; preds = %pregion_for_end.i.i, %pregion_for_entry.pregion_for_init4.i.i
  %_local_id_y.i.1 = phi i32 [ 0, %pregion_for_entry.pregion_for_init4.i.i ], [ %40, %pregion_for_end.i.i ]
  %add17.i.i = add i32 %_local_id_y.i.1, %mul15.i.i
  %add20.i.i = add i32 %add17.i.i, %13
  %cmp21.i.i = icmp ult i32 %add20.i.i, %16
  %mul23.i.i = mul i32 %add17.i.i, %19
  %cmp21.i.i.fr = freeze i1 %cmp21.i.i
  br i1 %cmp21.i.i.fr, label %pregion_for_entry.if.end.postbarrier.i.i.preheader, label %pregion_for_end.i.i

pregion_for_entry.if.end.postbarrier.i.i.preheader: ; preds = %pregion_for_entry.pregion_for_init.i.i
  br label %pregion_for_entry.if.end.postbarrier.i.i

pregion_for_entry.if.end.postbarrier.i.i:         ; preds = %if.end31.r_exit.i.i, %pregion_for_entry.if.end.postbarrier.i.i.preheader
  %_local_id_x.i.1 = phi i32 [ %38, %if.end31.r_exit.i.i ], [ 0, %pregion_for_entry.if.end.postbarrier.i.i.preheader ]
  %add13.i.i = add i32 %_local_id_x.i.1, %mul11.i.i
  %cmp18.i.i = icmp ult i32 %add13.i.i, %19
  br i1 %cmp18.i.i, label %if.then22.i.i, label %if.end31.r_exit.i.i

if.then22.i.i:                                    ; preds = %pregion_for_entry.if.end.postbarrier.i.i
  %add24.i.i = add i32 %add13.i.i, %mul23.i.i
  %arrayidx30.i.i = getelementptr inbounds float, ptr %7, i32 %add24.i.i
  %mul26.i.i = mul i32 %_local_id_x.i.1, 17
  %add28.i.i = add i32 %mul26.i.i, %_local_id_y.i.1
  %arrayidx29.i.i = getelementptr inbounds float, ptr %22, i32 %add28.i.i
  %37 = load float, ptr %arrayidx29.i.i, align 4, !tbaa !34, !llvm.access.group !48
  store float %37, ptr %arrayidx30.i.i, align 4, !tbaa !34, !llvm.access.group !48
  br label %if.end31.r_exit.i.i

if.end31.r_exit.i.i:                              ; preds = %if.then22.i.i, %pregion_for_entry.if.end.postbarrier.i.i
  %38 = add nuw i32 %_local_id_x.i.1, 1
  %exitcond.not = icmp eq i32 %38, %umax9
  br i1 %exitcond.not, label %pregion_for_end.i.i.loopexit, label %pregion_for_entry.if.end.postbarrier.i.i, !llvm.loop !52

pregion_for_end1.i.i:                             ; preds = %pregion_for_end.i.i
  %39 = add nuw i32 %_local_id_z.i.1, 1
  %exitcond8.not = icmp eq i32 %39, %umax13
  br i1 %exitcond8.not, label %_pocl_kernel_transpose.exit, label %pregion_for_entry.pregion_for_init4.i.i, !llvm.loop !54

pregion_for_end.i.i.loopexit:                     ; preds = %if.end31.r_exit.i.i
  br label %pregion_for_end.i.i

pregion_for_end.i.i:                              ; preds = %pregion_for_end.i.i.loopexit, %pregion_for_entry.pregion_for_init.i.i
  %40 = add nuw i32 %_local_id_y.i.1, 1
  %exitcond6.not = icmp eq i32 %40, %umax11
  br i1 %exitcond6.not, label %pregion_for_end1.i.i, label %pregion_for_entry.pregion_for_init.i.i, !llvm.loop !56

_pocl_kernel_transpose.exit:                      ; preds = %pregion_for_end1.i.i
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #2

attributes #0 = { alwaysinline nofree norecurse nosync nounwind memory(argmem: readwrite) "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "stackrealign" "target-features"="+32bit,+f,+m,+vortex" "uniform-work-group-size"="false" }
attributes #1 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3}
!opencl.ocl.version = !{!4}
!llvm.ident = !{!5}
!pocl_meta = !{!6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"ilp32f"}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 1, !"SmallDataLimit", i32 0}
!4 = !{i32 3, i32 0}
!5 = !{!"clang version 16.0.6 (git@github.com:vortexgpgpu/llvm.git 58811bfa61a503fd4a5f0dc7b57802fae51c3f5d)"}
!6 = !{!"device_address_bits", i64 32}
!7 = !{!"device_arg_buffer_launcher", i8 0}
!8 = !{!"device_grid_launcher", i8 0}
!9 = !{!"device_is_spmd", i8 0}
!10 = !{!"KernelName", !"transpose"}
!11 = !{!"WGMaxGridDimWidth", i64 0}
!12 = !{!"WGLocalSizeX", i64 0}
!13 = !{!"WGLocalSizeY", i64 0}
!14 = !{!"WGLocalSizeZ", i64 0}
!15 = !{!"WGDynamicLocalSize", i8 1}
!16 = !{!"WGAssumeZeroGlobalOffset", i8 1}
!17 = !{!"device_global_as_id", i64 0}
!18 = !{!"device_local_as_id", i64 0}
!19 = !{!"device_constant_as_id", i64 0}
!20 = !{!"device_args_as_id", i64 0}
!21 = !{!"device_context_as_id", i64 0}
!22 = !{!"device_side_printf", i8 1}
!23 = !{!"device_alloca_locals", i8 0}
!24 = !{!"device_max_witem_dim", i64 3}
!25 = !{!"device_max_witem_sizes_0", i64 4096}
!26 = !{!"device_max_witem_sizes_1", i64 4096}
!27 = !{!"device_max_witem_sizes_2", i64 4096}
!28 = !{i32 1, i32 1, i32 0, i32 0, i32 0, i32 3}
!29 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!30 = !{!"float*", !"float*", !"int", !"int", !"int", !"float*"}
!31 = !{!"", !"", !"", !"", !"", !""}
!32 = !{!"odata", !"idata", !"offset", !"width", !"height", !"block"}
!33 = !{i32 1}
!34 = !{!35, !35, i64 0}
!35 = !{!"float", !36, i64 0}
!36 = !{!"omnipotent char", !37, i64 0}
!37 = !{!"Simple C/C++ TBAA"}
!38 = !{!39, !40, !41}
!39 = distinct !{}
!40 = distinct !{}
!41 = distinct !{}
!42 = distinct !{!42, !43}
!43 = !{!"llvm.loop.parallel_accesses", !41}
!44 = distinct !{!44, !45}
!45 = !{!"llvm.loop.parallel_accesses", !40}
!46 = distinct !{!46, !47}
!47 = !{!"llvm.loop.parallel_accesses", !39}
!48 = !{!49, !50, !51}
!49 = distinct !{}
!50 = distinct !{}
!51 = distinct !{}
!52 = distinct !{!52, !53}
!53 = !{!"llvm.loop.parallel_accesses", !49}
!54 = distinct !{!54, !55}
!55 = !{!"llvm.loop.parallel_accesses", !51}
!56 = distinct !{!56, !57}
!57 = !{!"llvm.loop.parallel_accesses", !50}
