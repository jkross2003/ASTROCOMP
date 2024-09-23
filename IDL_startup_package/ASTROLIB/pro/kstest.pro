forward_function gaussfunc


pro kstest

  setcolors

  x=indgen(101)/4.-15.

  data1 = gaussfunc(x,MEAN=0.0,SIGMA=2.0)
  data2 = gaussfunc(x,MEAN=-5.0,SIGMA=2.0)
  plot, x, data1, psym=10, xr=[-15,10], yr=[0,0.5]
  oplot, x, data2, psym=10, linestyle=2, color=13
  kstwo, data1, data2, D, prob
  print, 'D=', D, '  prob=', prob

stop

  data1 = gaussfunc(x,MEAN=0.0,SIGMA=1.0)
  data2 = gaussfunc(x,MEAN=0.0,SIGMA=1.0)
  plot, x, data1, psym=10, xr=[-15,10], yr=[0,0.5]
  oplot, x, data2, psym=10, linestyle=2, color=13
  kstwo, data1, data2, D, prob
  print, 'D=', D, '  prob=', prob

stop

  data1 = gaussfunc(x,MEAN=0.0,SIGMA=1.0)
  data2 = gaussfunc(x,MEAN=0.1,SIGMA=0.9)
  plot, x, data1, psym=10, xr=[-15,10], yr=[0,0.5]
  oplot, x, data2, psym=10, linestyle=2, color=13
  kstwo, data1, data2, D, prob
  print, 'D=', D, '  prob=', prob

stop

  data1 = gaussfunc(x,MEAN=-0.83,SIGMA=1.32)
  data2 = gaussfunc(x,MEAN=-3.40,SIGMA=3.04)
  plot, x, data1, psym=10, xr=[-15,10], yr=[0,0.5]
  oplot, x, data2, psym=10, linestyle=2, color=13
  kstwo, data1, data2, D, prob
  print, 'D=', D, '  prob=', prob

return
end


function gaussfunc, x, MEAN=mean, SIGMA=sigma

  if not keyword_set(mean) then mean = 0d
  if not keyword_set(sigma) then sigma = 1d
  ret = 1d/sqrt(2d*!pi)/sigma*exp(-0.5*((x-mean)/sigma)^2)
  return, ret

end
