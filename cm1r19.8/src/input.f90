  MODULE input

  implicit none

  public

      integer, parameter :: maxq = 100   ! maximum possible number of
                                         ! q variables

      integer, parameter :: maxvars = 10000   ! maximum possible number of
                                              ! output variables

!-----------------------------------------------------------------------
!ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!cc                                       cccccccccccccccccccccccccccccc
!cc   Do not change anything below here   cccccccccccccccccccccccccccccc
!cc                                       cccccccccccccccccccccccccccccc
!ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!-----------------------------------------------------------------------

      integer ierr

!-----------------------------------

      logical terrain_flag,thflagval,qvflagval,procfiles,dowr,                                    &
              patchsws,patchsww,patchses,patchsee,                            &
              patchnwn,patchnww,patchnen,patchnee,                            &
              p2tchsws,p2tchsww,p2tchses,p2tchsee,                            &
              p2tchnwn,p2tchnww,p2tchnen,p2tchnee,stopit,                     &
              restart_file_theta,restart_file_dbz,restart_file_th0,           &
              restart_file_prs0,restart_file_pi0,restart_file_rho0,           &
              restart_file_qv0,restart_file_u0,restart_file_v0,               &
              restart_file_zs,restart_file_zh,restart_file_zf,                &
              restart_file_diags,restart_use_theta,restart_reset_frqtim,      &
              dosub,doturbdiag,doazimavg,dohifrq,dohturb,dovturb,pdcomp

!-----------------------------------------------------------------------

      integer nx,ny,nz,nodex,nodey,ppnode,timeformat,timestats,               &
              ni,nj,nk,nkp1,ngxy,ngz,                                         &
              ib,ie,jb,je,kb,ke,                                              &
              ibm,iem,jbm,jem,kbm,kem,                                        &
              ibi,iei,jbi,jei,kbi,kei,iice,idm,idmplus,                       &
              ibc,iec,jbc,jec,kbc,kec,                                        &
              ibt,iet,jbt,jet,kbt,ket,                                        &
              ibp,iep,jbp,jep,kbp,kep,                                        &
              itb,ite,jtb,jte,ktb,kte,                                        &
              ipb,ipe,jpb,jpe,kpb,kpe,                                        &
              ibr,ier,jbr,jer,kbr,ker,nir,njr,nkr,                            &
              ibb,ieb,jbb,jeb,kbb,keb,                                        &
              ibdt,iedt,jbdt,jedt,kbdt,kedt,ntdiag,                           &
              ibdq,iedq,jbdq,jedq,kbdq,kedq,nqdiag,                           &
              ibdv,iedv,jbdv,jedv,kbdv,kedv,nudiag,nvdiag,nwdiag,             &
              ibdk,iedk,jbdk,jedk,kbdk,kedk,nkdiag,                           &
              ibdp,iedp,jbdp,jedp,kbdp,kedp,npdiag,                           &
              ib2d,ie2d,jb2d,je2d,nout2d,                                     &
              ib3d,ie3d,jb3d,je3d,kb3d,ke3d,nout3d,                           &
              ibph,ieph,jbph,jeph,kbph,keph,                                  &
              ibl,iel,jbl,jel,                                                &
              ibb2,ibe2,jbb2,jbe2,kbb2,kbe2,                                  &
              d2i,d2is,d2iu,d2iv,                                             &
              d2j,d2js,d2ju,d2jv,                                             &
              d3i,d3is,d3iu,d3iv,                                             &
              d3j,d3js,d3ju,d3jv,                                             &
              d3n,d3t,mynode,nodemaster,nodes,                                &
              ibzvd,iezvd,jbzvd,jezvd,kbzvd,kezvd,nqzvd,                      &
              imirror,jmirror,                                                &
              imp,jmp,kmp,kmt,rmp,cmp,nrain,                                  &
              numq,nqv,nqc,nqr,nqi,nqs,nqg,                                   &
              prx,pry,prz,pru,prv,prw,prth,prt,prprs,                         &
              prpt1,prpt2,prqv,prq1,prq2,prnc1,prnc2,prkm,prkh,prtke,         &
              prdbz,prb,prvpg,przv,prrho,prqsl,prqsi,prznt,prust,przs,prsig,  &
              nql1,nql2,nqs1,nqs2,nnc1,nnc2,nvl1,nvl2,nzl1,nzl2,              &
              nbudget,budrain,cm1setup,testcase,                              &
              adapt_dt,irst,rstnum,iconly,                                    &
              hadvordrs,vadvordrs,hadvordrv,vadvordrv,pdscheme,apmasscon,     &
              advwenos,advwenov,weno_order,                                   &
              idiff,mdiff,difforder,imoist,sgsmodel,horizturb,                &
              tconfig,bcturbs,doimpl,                                         &
              irdamp,hrdamp,psolver,nsound,ptype,ihail,iautoc,                &
              icor,lspgrad,eqtset,idiss,efall,rterm,betaplane,                &
              wbc,ebc,sbc,nbc,bbc,tbc,irbc,roflux,nudgeobc,                   &
              isnd,iwnd,itern,iinit,                                          &
              irandp,ibalance,iorigin,axisymm,imove,iptra,npt,pdtra,          &
              iprcl,nparcels,                                                 &
              stretch_x,stretch_y,stretch_z,                                  &
              bc_temp,ibw,ibe,ibs,ibn,strlen,baselen,totlen,npvals,           &
              outfile,myid,numprocs,myi,myj,nf,nu,nv,nw,                      &
              mywest,myeast,mysouth,mynorth,mysw,mynw,myne,myse,              &
              cs1we,cs1sn,ct1we,ct1sn,cv1we,cu1sn,cw1we,cw1sn,cs2we,cs2sn,    &
              cs3we,cs3sn,ct3we,ct3sn,cv3we,cu3sn,cw3we,cw3sn,cs3weq,cs3snq,  &
              output_format,output_filetype,output_interp,                    &
              restart_format,restart_filetype,                                &
              output_rain,output_sws,output_svs,output_sps,output_srs,        &
              output_sgs,output_sus,output_shs,output_coldpool,output_zs,     &
              output_psfc,                                                    &
              output_basestate,output_sfcflx,output_sfcparams,output_sfcdiags,&
              output_zh,output_th,output_thpert,output_prs,output_prspert,    &
              output_pi,output_pipert,output_rho,output_rhopert,output_tke,   &
              output_km,output_kh,                                            &
              output_qv,output_qvpert,output_q,output_dbz,output_buoyancy,    &
              output_u,output_upert,output_uinterp,                           &
              output_v,output_vpert,output_vinterp,output_w,output_winterp,   &
              output_vort,output_pv,output_uh,output_pblten,                  &
              output_dissten,output_fallvel,output_nm,output_def,             &
              output_radten,output_cape,output_cin,output_lcl,output_lfc,     &
              output_pwat,output_lwp,                                         &
              output_thbudget,output_qvbudget,                                &
              output_ubudget,output_vbudget,output_wbudget,output_pdcomp,     &
              prcl_th,prcl_t,prcl_prs,prcl_ptra,prcl_q,prcl_nc,               &
              prcl_km,prcl_kh,prcl_tke,prcl_dbz,prcl_b,prcl_vpg,prcl_vort,    &
              prcl_rho,prcl_qsat,prcl_sfc,                                    &
              n_out,s_out,u_out,v_out,w_out,z_out,sout2d,sout3d,              &
              stat_w,stat_wlevs,stat_u,stat_v,stat_rmw,                       &
              stat_pipert,stat_prspert,stat_thpert,stat_q,                    &
              stat_tke,stat_km,stat_kh,stat_div,stat_rh,stat_rhi,stat_the,    &
              stat_cloud,stat_sfcprs,stat_wsp,stat_cfl,stat_vort,             &
              stat_tmass,stat_tmois,stat_qmass,stat_tenerg,stat_mo,stat_tmf,  &
              stat_pcn,stat_qsrc,stat_out,prcl_out,                           &
              radopt,year,month,day,hour,minute,second,jday,                  &
              isfcflx,sfcmodel,oceanmodel,ipbl,initsfc,lu0,season,            &
              cecd,pertflx,isftcflx,iz0tlnd,convinit,wnudge,maxk,             &
              set_znt,set_flx,set_ust,                                        &
              qd_dbz,qd_vtc,qd_vtr,qd_vts,qd_vtg,qd_vti,                      &
              td_hadv,td_vadv,td_hturb,td_vturb,td_mp,td_rdamp,               &
              td_rad,td_div,td_diss,td_pbl,td_subs,td_efall,                  &
              td_cond,td_evac,td_evar,td_dep,td_subl,td_melt,td_frz,          &
              qd_hadv,qd_vadv,qd_hturb,qd_vturb,qd_mp,qd_pbl,qd_subs,         &
              qd_cond,qd_evac,qd_evar,qd_dep,qd_subl,                         &
              ud_hadv,ud_vadv,ud_diag,ud_hturb,ud_vturb,ud_pgrad,ud_rdamp,            &
              ud_pbl,ud_cor,ud_cent,ud_subs,                                  &
              vd_hadv,vd_vadv,vd_diag,vd_hturb,vd_vturb,vd_pgrad,vd_rdamp,            &
              vd_pbl,vd_cor,vd_cent,vd_subs,                                  &
              wd_hadv,wd_vadv,wd_hturb,wd_vturb,wd_pgrad,wd_rdamp,wd_buoy,    &
              kd_adv,kd_turb,                                                 &
              td_hidiff,td_vidiff,td_hediff,td_vediff,                        &
              qd_hidiff,qd_vidiff,qd_hediff,qd_vediff,                        &
              ud_hidiff,ud_vidiff,ud_hediff,ud_vediff,                        &
              vd_hidiff,vd_vidiff,vd_hediff,vd_vediff,                        &
              wd_hidiff,wd_vidiff,wd_hediff,wd_vediff,                        &
              iusekm,iusekh

!-----------------------------------------------------------------------

      real control_lve,control_vadv,control_wprof,fracMSEadv,dx,dy,dz,dtl,timax,run_time,              &
           tapfrq,rstfrq,statfrq,prclfrq,turbfrq,azimavgfrq,hifrqfrq,         &
           kdiff2,kdiff6,fcor,kdiv,alph,rdalpha,zd,xhd,alphobc,umove,vmove,   &
           v_t,l_h,lhref1,lhref2,l_inf,ndcnst,cnstce,cnstcd,                  &
           dx_inner,dx_outer,nos_x_len,tot_x_len,                             &
           dy_inner,dy_outer,nos_y_len,tot_y_len,                             &
           ztop,str_bot,str_top,dz_bot,dz_top,                                &
           ptc_top,ptc_bot,viscosity,pr_num,                                  &
           rdx,rdy,rdz,rdx2,rdy2,rdz2,rdx4,rdy4,rdz4,                         &
           minx,maxx,miny,maxy,maxz,zt,rzt,pmin,                              &
           sfctheta,thec_mb,qt_mb,smeps,tsmall,qsmall,cflmax,ksmax,           &
           var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,                &
           dtrad,ctrlat,ctrlon,                                               &
           tsk0,tmn0,xland0,oml_hml0,oml_gamma,                               &
           dmax,zdeep,lamx,lamy,xcent,ycent,aconv,convtime,                   &
           xc_uforce,xr_uforce,zr_uforce,alpha_uforce,t1_uforce,t2_uforce,    &
           xc_wnudge,xr_wnudge,zr_wnudge,alpha_wnudge,t1_wnudge,t2_wnudge,    &
           yc_wnudge,yr_wnudge,zc_wnudge,wmax_wnudge,                         &
           rxrwnudge,ryrwnudge,rzrwnudge,                                     &
           min_dx,min_dy,min_dz,max_dx,max_dy,max_dz,                         &
           cgs1,cgs2,cgs3,cgt1,cgt2,cgt3,                                     &
           dgs1,dgs2,dgs3,dgt1,dgt2,dgt3,                                     &
           wbe1,wbe2,wbe3,wte1,wte2,wte3,                                     &
           csound,hurr_rad,                                                   &
           cnst_znt,cnst_shflx,cnst_lhflx,cnst_ust,                           &
           ddr,rlen,centerx,centery

!-----------------------------------------------------------------------

      character(len=70) output_path,output_basename,string,sstring,statfile

!-----------------------------------------------------------------------
!  timestats:

      real clock_rate,time_sound,time_buoyan,time_turb,              &
           time_diffu,time_microphy,time_stat,time_cflq,time_bc,     &
           time_misc,time_integ,time_rdamp,time_divx,time_write,     &
           time_ttend,time_cor,time_fall,time_satadj,                &
           time_sfcphys,time_dbz,time_last,                          &
           time_advs,time_advu,time_advv,time_advw,                  &
           time_mpu1,time_mpv1,time_mpw1,time_mpp1,                  &
           time_mpu2,time_mpv2,time_mpw2,time_mpp2,                  &
           time_mps1,time_mps3,time_mpq1,time_mptk1,                 &
           time_mps2,time_mps4,time_mpq2,time_mptk2,time_mpb,        &
           time_parcels,time_rad,time_pbl,time_swath,time_pdef,      &
           time_prsrho,time_restart,time_poiss,time_turbdiag,        &
           time_azimavg,time_hifrq
      integer count_last

!-----------------------------------------------------------------------

      namelist /param0/ nx,ny,nz,nodex,nodey,ppnode,control_lve,control_vadv, &
                        control_wprof, fracMSEadv, thflagval,qvflagval,                 &
                        timeformat,timestats,terrain_flag,procfiles
      namelist /param1/ dx,dy,dz,dtl,timax,run_time,                    &
                        tapfrq,rstfrq,statfrq,prclfrq
      namelist /param2/                                                 &
          cm1setup,testcase,adapt_dt,irst,rstnum,iconly,                &
          hadvordrs,vadvordrs,hadvordrv,vadvordrv,                      &
          advwenos,advwenov,weno_order,                                 &
          apmasscon,idiff,mdiff,difforder,imoist,                       &
          ipbl,sgsmodel,tconfig,bcturbs,horizturb,doimpl,               &
          irdamp,hrdamp,psolver,ptype,ihail,iautoc,                     &
          icor,lspgrad,eqtset,idiss,efall,rterm,                        &
          wbc,ebc,sbc,nbc,bbc,tbc,irbc,roflux,nudgeobc,                 &
          isnd,iwnd,itern,iinit,                                        &
          irandp,ibalance,iorigin,axisymm,imove,iptra,npt,pdtra,        &
          iprcl,nparcels
      namelist /param3/ kdiff2,kdiff6,fcor,kdiv,alph,rdalpha,zd,xhd,alphobc, &
                        umove,vmove,v_t,l_h,lhref1,lhref2,l_inf,ndcnst
      namelist /param4/ stretch_x,dx_inner,dx_outer,nos_x_len,tot_x_len
      namelist /param5/ stretch_y,dy_inner,dy_outer,nos_y_len,tot_y_len
      namelist /param6/ stretch_z,ztop,str_bot,str_top,dz_bot,dz_top
      namelist /param7/ bc_temp,ptc_top,ptc_bot,viscosity,pr_num
      namelist /param8/ var1,var2,var3,var4,var5,var6,var7,var8,var9,var10
      namelist /param9/                                                       &
              output_path,output_basename,output_format,output_filetype,      &
              output_interp,                                                  &
              output_rain,output_sws,output_svs,output_sps,output_srs,        &
              output_sgs,output_sus,output_shs,output_coldpool,               &
              output_sfcflx,output_sfcparams,output_sfcdiags,                 &
              output_psfc,output_zs,output_zh,output_basestate,               &
              output_th,output_thpert,output_prs,output_prspert,              &
              output_pi,output_pipert,output_rho,output_rhopert,output_tke,   &
              output_km,output_kh,                                            &
              output_qv,output_qvpert,output_q,output_dbz,output_buoyancy,    &
              output_u,output_upert,output_uinterp,                           &
              output_v,output_vpert,output_vinterp,output_w,output_winterp,   &
              output_vort,output_pv,output_uh,output_pblten,                  &
              output_dissten,output_fallvel,output_nm,output_def,             &
              output_radten,output_cape,output_cin,output_lcl,output_lfc,     &
              output_pwat,output_lwp,                                         &
              output_thbudget,output_qvbudget,                                &
              output_ubudget,output_vbudget,output_wbudget,output_pdcomp
      namelist /param16/                                                      &
              restart_format,restart_filetype,restart_reset_frqtim,           &
              restart_file_theta,restart_file_dbz,restart_file_th0,           &
              restart_file_prs0,restart_file_pi0,restart_file_rho0,           &
              restart_file_qv0,restart_file_u0,restart_file_v0,               &
              restart_file_zs,restart_file_zh,restart_file_zf,                &
              restart_file_diags,restart_use_theta
      namelist /param10/                                                      &
              stat_w,stat_wlevs,stat_u,stat_v,stat_rmw,                       &
              stat_pipert,stat_prspert,stat_thpert,stat_q,                    &
              stat_tke,stat_km,stat_kh,stat_div,stat_rh,stat_rhi,stat_the,    &
              stat_cloud,stat_sfcprs,stat_wsp,stat_cfl,stat_vort,             &
              stat_tmass,stat_tmois,stat_qmass,stat_tenerg,stat_mo,stat_tmf,  &
              stat_pcn,stat_qsrc
      namelist /param11/                                                      &
              radopt,dtrad,ctrlat,ctrlon,year,month,day,hour,minute,second
      namelist /param12/                                                      &
              isfcflx,sfcmodel,oceanmodel,initsfc,                            &
              tsk0,tmn0,xland0,lu0,season,                                    &
              cecd,pertflx,cnstce,cnstcd,                                     &
              isftcflx,iz0tlnd,oml_hml0,oml_gamma,                            &
              set_flx,cnst_shflx,cnst_lhflx,                                  &
              set_znt,cnst_znt,set_ust,cnst_ust
      namelist /param13/                                                      &
              prcl_th,prcl_t,prcl_prs,prcl_ptra,prcl_q,prcl_nc,               &
              prcl_km,prcl_kh,prcl_tke,prcl_dbz,prcl_b,prcl_vpg,prcl_vort,    &
              prcl_rho,prcl_qsat,prcl_sfc
      namelist /param14/                                                      &
              doturbdiag,turbfrq
      namelist /param15/                                                      &
              doazimavg,azimavgfrq,ddr,rlen

    CONTAINS

    !ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

      real function mytime()
      implicit none

      integer count,rate,max
      real time_current,rcount

      !  Platform-independent timer

      call system_clock(count,rate,max)
      if( count.lt.count_last )then
        ! simple kludge ... do nothing
        ! fix some other day   (GHB, 101018)
!!!        rcount = float(count+max)
!!!        time_current=rcount*clock_rate
!!!        mytime=time_current-time_last
!!!        rcount = float(count)
!!!        time_current=rcount*clock_rate
        rcount = float(count)
        time_current=rcount*clock_rate
        mytime=0.0
      else
        rcount = float(count)
        time_current=rcount*clock_rate
        mytime=time_current-time_last
      endif
      time_last=time_current
      count_last=count

      end function mytime

    !ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

  END MODULE input
