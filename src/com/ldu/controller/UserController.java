package com.ldu.controller;


import com.ldu.pojo.*;
import com.ldu.service.*;
import com.ldu.util.DateUtil;
import com.ldu.util.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private PurseService purseService;
    @Autowired
    private FocusService focusService;


    @RequestMapping("/addUser")
    public String addUser(HttpServletRequest request, User user1){
        String url = request.getHeader("Referer");
        User user = userService.getUserByPhone(user1.getPhone());

        if (user == null) {// 检测该用户是否已经注册
            String t = DateUtil.getNowDate();
            // 对密码进行MD5加密
            String str = MD5.md5(user1.getPassword());
            user1.setCreateAt(t);// 创建开始时间
            user1.setPassword(str);
            user1.setGoodsNum(0);
            user1.setStatus((byte) 1);//初始正常状态
            user1.setPower(100);
            userService.addUser(user1);
            purseService.addPurse(user1.getId());// 注册的时候同时生成钱包
        }
        return "redirect:" + url;
    }

    @RequestMapping(value = "/changeName")
    public ModelAndView changeName(HttpServletRequest request, User user, ModelMap modelMap) {
        String url = request.getHeader("Referer");
        // 从session中获取出当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        cur_user.setUsername(user.getUsername());// 更改当前用户的用户名
        userService.updateUserName(cur_user);// 执行修改操作
        request.getSession().setAttribute("cur_user", cur_user);// 修改session值
        return new ModelAndView("redirect:" + url);
    }

    @RequestMapping("/login")
    public String loginValidate(HttpServletRequest request, HttpServletResponse response, User user){
        String url = request.getHeader("Referer");
        User cur_user = userService.getUserByPhone(user.getPhone());


        if(cur_user != null){
            String pwd = MD5.md5(user.getPassword());
            if (pwd.equals(cur_user.getPassword())) {
                if(cur_user.getStatus()==1) {
                    request.getSession().setAttribute("cur_user", cur_user);
                    return "redirect:" + url;
                }
            }
        }
        return "redirect:" + url;
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        request.getSession().setAttribute("cur_user", null);
        return "redirect:/goods/homeGoods";
    }

    @RequestMapping(value = "/register",method = RequestMethod.POST)
    @ResponseBody
    public String register(HttpServletRequest request){
        String phone=request.getParameter("phone");
        User user = userService.getUserByPhone(phone);
        if(user==null) {
            return "{\"success\":true,\"flag\":false}";//用户存在，注册失败
        }else {
            return "{\"success\":true,\"flag\":true}";//用户不存在，可以注册
        }
    }

    @RequestMapping("/allGoods")
    public ModelAndView goods(HttpServletRequest request) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
        List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
        for (int i = 0; i < goodsList.size(); i++) {
            // 将用户信息和image信息封装到GoodsExtend类中，传给前台
            GoodsExtend goodsExtend = new GoodsExtend();
            Goods goods = goodsList.get(i);
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(images);
            goodsAndImage.add(i, goodsExtend);
        }
        Purse myPurse = purseService.getPurseByUserId(userId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("goodsAndImage", goodsAndImage);
        mv.setViewName("/user/goods");
        mv.addObject("myPurse", myPurse);
        return mv;
    }

    @RequestMapping("/addFocus/{id}")
    public String focus(HttpServletRequest request, @PathVariable("id")Integer goods_id){
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer cur_userId = cur_user.getId();
        List<Focus> focusList = focusService.getFocusByUserId(cur_userId);

        if (focusList.isEmpty()){
            focusService.addFocusByUserIdAndId(goods_id, cur_userId);
            return "redirect:/user/allFocus";
        }

        for (Focus myFocus: focusList) {
            if (goods_id==myFocus.getGoodsId()){
                return "redirect:/user/allFocus";
            }
        }
        focusService.addFocusByUserIdAndId(goods_id, cur_userId);
        return "redirect:/user/allFocus";
    }

    @RequestMapping("allFocus")
    public ModelAndView allFocus(HttpServletRequest request){
        //get user id
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();

        List<Focus> focusList = focusService.getFocusByUserId(user_id);
        List<GoodsExtend> goodsExtendList = new ArrayList<GoodsExtend>();

        //get every focused items and take them out
        for(int i=0;i<focusList.size();i++){
            GoodsExtend goodsExtend = new GoodsExtend();
            Focus focus = focusList.get(i);
            Goods goods = goodsService.getGoodsByPrimaryKey(focus.getGoodsId());
            List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(focus.getGoodsId());
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(imageList);
            //put goodsExtend at i position
            goodsExtendList.add(i, goodsExtend);

        }

        Purse purse = purseService.getPurseByUserId(user_id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/user/focus");
        modelAndView.addObject("myPurse", purse);
        modelAndView.addObject("goodsAndImage", goodsExtendList);
        return modelAndView;
    }

    @RequestMapping("deleteFocus/{id}")
    public String deleteFocus(HttpServletRequest request, @PathVariable("id")Integer goods_id){
        //get user id
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();

        focusService.deleteFocusByUserIdAndGoodsId(user_id, goods_id);
        return "redirect:/user/allFocus";
    }

    @RequestMapping("basic")
    public ModelAndView personalSetting(HttpServletRequest request){
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        Purse myPurse = purseService.getPurseByUserId(userId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("myPurse", myPurse);
        mv.setViewName("/user/basic");
        return mv;
    }
}
