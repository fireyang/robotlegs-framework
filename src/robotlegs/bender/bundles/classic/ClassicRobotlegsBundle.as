//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.bundles.classic
{
	import robotlegs.bender.bundles.shared.configs.ContextViewListenerConfig;
	import robotlegs.bender.extensions.commandMap.CommandMapExtension;
	import robotlegs.bender.extensions.contextView.ContextViewExtension;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtension;
	import robotlegs.bender.extensions.eventDispatcher.EventDispatcherExtension;
	import robotlegs.bender.extensions.localEventMap.LocalEventMapExtension;
	import robotlegs.bender.extensions.logging.TraceLoggingExtension;
	import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
	import robotlegs.bender.extensions.modularity.ModularityExtension;
	import robotlegs.bender.extensions.stageSync.StageSyncExtension;
	import robotlegs.bender.extensions.viewManager.ManualStageObserverExtension;
	import robotlegs.bender.extensions.viewManager.StageObserverExtension;
	import robotlegs.bender.extensions.viewManager.ViewManagerExtension;
	import robotlegs.bender.framework.context.api.IContext;
	import robotlegs.bender.framework.context.api.IContextConfig;

	/**
	 * For that Classic Robotlegs flavour.
	 *
	 * <p>This bundle installs a number of extensions commonly used in typical Robotlegs
	 * applications and modules.</p>
	 */
	public class ClassicRobotlegsBundle implements IContextConfig
	{

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function configureContext(context:IContext):void
		{
			context.require(
				TraceLoggingExtension,
				ContextViewExtension,
				EventDispatcherExtension,
				ModularityExtension,
				StageSyncExtension,
				CommandMapExtension,
				EventCommandMapExtension,
				LocalEventMapExtension,
				ViewManagerExtension,
				StageObserverExtension,
				ManualStageObserverExtension,
				MediatorMapExtension,
				ContextViewListenerConfig);
		}
	}
}
