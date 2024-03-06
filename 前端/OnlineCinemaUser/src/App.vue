<template>
    <div id="app" class="backtop" style="height: 700px; overflow-y: auto">
        <router-view></router-view>
    <el-backtop target=".backtop" :visibility-height=200></el-backtop>
    </div>
</template>

<script>

export default {
    name:"App"
}
</script>

<style>
    *{
        /* margin: 0px; */
        /* padding: 0px; */
        list-style-type: none;
    }
</style>
