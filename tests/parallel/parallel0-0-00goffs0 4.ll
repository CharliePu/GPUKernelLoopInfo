; ModuleID = 'parallel.bc'
source_filename = "parallel_bc"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

%struct.latLong = type { float, float }

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #0

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal fastcc float @_Z8_cl_sqrtf(float noundef %0) unnamed_addr #1 {
  %2 = tail call float @llvm.sqrt.f32(float %0)
  ret float %2
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #0

declare i32 @vx_thread_id(...) local_unnamed_addr

declare i32 @vx_warp_id(...) local_unnamed_addr

declare i32 @vx_num_threads(...) local_unnamed_addr

declare i32 @vx_num_warps(...) local_unnamed_addr

; Function Attrs: alwaysinline mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define void @_pocl_kernel_NearestNeighbor(ptr nocapture noundef readonly align 4 %0, ptr nocapture noundef writeonly align 4 %1, i32 noundef %2, float noundef %3, float noundef %4, ptr nocapture readonly %5, i32 %6, i32 %7, i32 %8) local_unnamed_addr #2 !kernel_arg_addr_space !28 !kernel_arg_access_qual !29 !kernel_arg_type !30 !kernel_arg_base_type !31 !kernel_arg_type_qual !32 !kernel_arg_name !33 !pocl_generated !34 {
  %10 = getelementptr inbounds { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %5, i32 0, i32 2
  %11 = load i32, ptr %10, align 4
  %12 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %5, i32 0, i32 2, i32 1
  %13 = load i32, ptr %12, align 4
  %14 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %5, i32 0, i32 2, i32 2
  %15 = load i32, ptr %14, align 4
  %nl_xy.i = mul i32 %13, %11
  %nl_xyz.i = mul i32 %nl_xy.i, %15
  %tid.i = tail call i32 (...) @vx_thread_id() #3
  %wid.i = tail call i32 (...) @vx_warp_id() #3
  %nHT.i = tail call i32 (...) @vx_num_threads() #3
  %nHW.i = tail call i32 (...) @vx_num_warps() #3
  %16 = mul i32 %nHT.i, %wid.i
  %tlid.i = add i32 %16, %tid.i
  %HTpC.i = mul i32 %nHW.i, %nHT.i
  %17 = icmp ult i32 %tlid.i, %nl_xyz.i
  br i1 %17, label %pregion_for_entry.entry.i.lr.ph, label %NearestNeighbor.exit, !llvm.loop !35

pregion_for_entry.entry.i.lr.ph:                  ; preds = %9
  %18 = mul i32 %11, %6
  br label %pregion_for_entry.entry.i

pregion_for_entry.entry.i:                        ; preds = %if.end.r_exit.i, %pregion_for_entry.entry.i.lr.ph
  %.pocl.vortex_local_id.i.01 = phi i32 [ %tlid.i, %pregion_for_entry.entry.i.lr.ph ], [ %23, %if.end.r_exit.i ]
  %new_lid_x.i = urem i32 %.pocl.vortex_local_id.i.01, %11
  %19 = add i32 %new_lid_x.i, %18
  %cmp.i = icmp slt i32 %19, %2
  br i1 %cmp.i, label %if.then.i, label %if.end.r_exit.i

if.then.i:                                        ; preds = %pregion_for_entry.entry.i
  %add.ptr.i = getelementptr inbounds %struct.latLong, ptr %0, i32 %19
  %add.ptr1.i = getelementptr inbounds float, ptr %1, i32 %19
  %20 = load float, ptr %add.ptr.i, align 4, !tbaa !38, !llvm.access.group !43
  %sub.i = fsub float %3, %20
  %lng5.i = getelementptr inbounds %struct.latLong, ptr %0, i32 %19, i32 1
  %21 = load float, ptr %lng5.i, align 4, !tbaa !44, !llvm.access.group !43
  %sub6.i = fsub float %4, %21
  %mul9.i = fmul float %sub6.i, %sub6.i
  %22 = tail call float @llvm.fmuladd.f32(float %sub.i, float %sub.i, float %mul9.i)
  %call10.i = tail call fastcc float @_Z8_cl_sqrtf(float noundef %22) #4
  store float %call10.i, ptr %add.ptr1.i, align 4, !tbaa !45, !llvm.access.group !43
  br label %if.end.r_exit.i

if.end.r_exit.i:                                  ; preds = %if.then.i, %pregion_for_entry.entry.i
  %23 = add i32 %.pocl.vortex_local_id.i.01, %HTpC.i
  %24 = icmp ult i32 %23, %nl_xyz.i
  br i1 %24, label %pregion_for_entry.entry.i, label %NearestNeighbor.exit.loopexit, !llvm.loop !35

NearestNeighbor.exit.loopexit:                    ; preds = %if.end.r_exit.i
  br label %NearestNeighbor.exit

NearestNeighbor.exit:                             ; preds = %NearestNeighbor.exit.loopexit, %9
  ret void
}

; Function Attrs: nounwind
define void @_pocl_kernel_NearestNeighbor_workgroup(ptr nocapture readonly %0, ptr nocapture readonly %1, i32 %2, i32 %3, i32 %4) local_unnamed_addr #3 {
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
  %16 = load float, ptr %15, align 4
  %17 = getelementptr ptr, ptr %0, i32 4
  %18 = load ptr, ptr %17, align 4
  %19 = load float, ptr %18, align 4
  %20 = getelementptr inbounds { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %1, i32 0, i32 2
  %21 = load i32, ptr %20, align 4
  %22 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %1, i32 0, i32 2, i32 1
  %23 = load i32, ptr %22, align 4
  %24 = getelementptr { [3 x i32], [3 x i32], [3 x i32], ptr, ptr, i32, ptr, i32 }, ptr %1, i32 0, i32 2, i32 2
  %25 = load i32, ptr %24, align 4
  %nl_xy.i.i = mul i32 %23, %21
  %nl_xyz.i.i = mul i32 %nl_xy.i.i, %25
  %tid.i.i = tail call i32 (...) @vx_thread_id() #3
  %wid.i.i = tail call i32 (...) @vx_warp_id() #3
  %nHT.i.i = tail call i32 (...) @vx_num_threads() #3
  %nHW.i.i = tail call i32 (...) @vx_num_warps() #3
  %26 = mul i32 %nHT.i.i, %wid.i.i
  %tlid.i.i = add i32 %26, %tid.i.i
  %HTpC.i.i = mul i32 %nHW.i.i, %nHT.i.i
  %27 = icmp ult i32 %tlid.i.i, %nl_xyz.i.i
  br i1 %27, label %pregion_for_entry.entry.i.i.lr.ph, label %_pocl_kernel_NearestNeighbor.exit, !llvm.loop !35

pregion_for_entry.entry.i.i.lr.ph:                ; preds = %5
  %28 = mul i32 %21, %2
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %if.end.r_exit.i.i, %pregion_for_entry.entry.i.i.lr.ph
  %.pocl.vortex_local_id.i.i.01 = phi i32 [ %tlid.i.i, %pregion_for_entry.entry.i.i.lr.ph ], [ %33, %if.end.r_exit.i.i ]
  %new_lid_x.i.i = urem i32 %.pocl.vortex_local_id.i.i.01, %21
  %29 = add i32 %new_lid_x.i.i, %28
  %cmp.i.i = icmp slt i32 %29, %13
  br i1 %cmp.i.i, label %if.then.i.i, label %if.end.r_exit.i.i

if.then.i.i:                                      ; preds = %pregion_for_entry.entry.i.i
  %add.ptr.i.i = getelementptr inbounds %struct.latLong, ptr %7, i32 %29
  %add.ptr1.i.i = getelementptr inbounds float, ptr %10, i32 %29
  %30 = load float, ptr %add.ptr.i.i, align 4, !tbaa !38, !llvm.access.group !43
  %sub.i.i = fsub float %16, %30
  %lng5.i.i = getelementptr inbounds %struct.latLong, ptr %7, i32 %29, i32 1
  %31 = load float, ptr %lng5.i.i, align 4, !tbaa !44, !llvm.access.group !43
  %sub6.i.i = fsub float %19, %31
  %mul9.i.i = fmul float %sub6.i.i, %sub6.i.i
  %32 = tail call float @llvm.fmuladd.f32(float %sub.i.i, float %sub.i.i, float %mul9.i.i)
  %call10.i.i = tail call fastcc float @_Z8_cl_sqrtf(float noundef %32) #4
  store float %call10.i.i, ptr %add.ptr1.i.i, align 4, !tbaa !45, !llvm.access.group !43
  br label %if.end.r_exit.i.i

if.end.r_exit.i.i:                                ; preds = %if.then.i.i, %pregion_for_entry.entry.i.i
  %33 = add i32 %.pocl.vortex_local_id.i.i.01, %HTpC.i.i
  %34 = icmp ult i32 %33, %nl_xyz.i.i
  br i1 %34, label %pregion_for_entry.entry.i.i, label %_pocl_kernel_NearestNeighbor.exit.loopexit, !llvm.loop !35

_pocl_kernel_NearestNeighbor.exit.loopexit:       ; preds = %if.end.r_exit.i.i
  br label %_pocl_kernel_NearestNeighbor.exit

_pocl_kernel_NearestNeighbor.exit:                ; preds = %_pocl_kernel_NearestNeighbor.exit.loopexit, %5
  ret void
}

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "frame-pointer"="all" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+f,+m,+vortex" }
attributes #2 = { alwaysinline mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "stackrealign" "target-features"="+32bit,+f,+m,+vortex" "uniform-work-group-size"="false" }
attributes #3 = { nounwind }
attributes #4 = { nobuiltin nounwind willreturn memory(none) "no-builtins" }

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
!10 = !{!"KernelName", !"NearestNeighbor"}
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
!28 = !{i32 1, i32 1, i32 0, i32 0, i32 0}
!29 = !{!"none", !"none", !"none", !"none", !"none"}
!30 = !{!"LatLong*", !"float*", !"int", !"float", !"float"}
!31 = !{!"struct latLong*", !"float*", !"int", !"float", !"float"}
!32 = !{!"", !"", !"", !"", !""}
!33 = !{!"d_locations", !"d_distances", !"numRecords", !"lat", !"lng"}
!34 = !{i32 1}
!35 = distinct !{!35, !36}
!36 = !{!"llvm.loop.parallel_accesses", !37}
!37 = distinct !{}
!38 = !{!39, !40, i64 0}
!39 = !{!"latLong", !40, i64 0, !40, i64 4}
!40 = !{!"float", !41, i64 0}
!41 = !{!"omnipotent char", !42, i64 0}
!42 = !{!"Simple C/C++ TBAA"}
!43 = !{!37}
!44 = !{!39, !40, i64 4}
!45 = !{!40, !40, i64 0}
